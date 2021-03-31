
//MARK:- Start
import UIKit
import moltin

class CheckoutConfirmationViewController: UIViewController {

    //MARK:- Variables Declaration
    var orderId : Order?
    var cartItems: [moltin.CartItem] = Array()
    var productsInCart: [moltin.Product] = Array()
    
    //MARK:- Outlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voucherCodeLabel: UILabel!
    @IBOutlet weak var paymentMethodsLabel: UILabel!
    @IBOutlet weak var yourItemsLabel: UILabel!
    @IBOutlet weak var voucherCodeLabelValue: UILabel!
    @IBOutlet weak var paymentMethodsLabelValue: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var checkoutTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalLabelValue: UILabel!
    @IBOutlet weak var buyNowButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.voucherCodeLabel.isHidden = true
        self.voucherCodeLabelValue.isHidden = true
        
        MoltinProducts.instance().getCart(cartId: "") { (cart) -> (Void) in
            self.totalLabel.text = cart?.meta?.displayPrice.withTax.formatted
        }
        
        self.voucherCodeLabel.text = orderId?.status
        self.paymentMethodsLabel.text = orderId?.payment
        
        checkoutTableView.register(UINib(nibName: "ConfirmationTableViewCell", bundle: nil), forCellReuseIdentifier: "ConfirmationCell")
        
        MoltinProducts.instance().getCartItems(cartId: "") { (CartItems) -> (Void) in
            self.cartItems = CartItems
            let productIds = self.cartItems.map({ $0.productId })
            
            for id in productIds {
                MoltinProducts.instance().getProductById(productId: id ?? "") { (product) -> (Void) in
                    let productItem = product
                    self.productsInCart.insert(productItem!, at: self.productsInCart.endIndex)
                    
                    DispatchQueue.main.async {
                        self.checkoutTableView.reloadData()
                    }
                }
            }
        }
    }
    
    //MARK:- User-Defined Function
    func hidePromo() {
        self.voucherCodeLabel.isHidden = true
        self.voucherCodeLabelValue.isHidden = true
    }
    
    //MARK:- Button Actions
    @IBAction func backButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "CheckoutFlow", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CartView") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func buyNowButtonTapped(_ sender: UIButton) {
        let paymentMethod = ManuallyAuthorizePayment()
        
        MoltinProducts.instance().payForOrder(order: self.orderId!, paymentMethod: paymentMethod) { (paymentWorked) -> (Void) in
            if paymentWorked {
                let title = paymentWorked ? "Your purchase is on the way" : "There was an error with your payment"
                let message = paymentWorked ? "Continue to see your receipt" : "Please Try again"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: title, style: .cancel, handler: { (action) in
                    if (paymentWorked) {
                        let storyBoard = UIStoryboard(name: "CheckoutFlow", bundle: nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "Receipt") as
                        UIViewController
                        self.present(vc, animated: true, completion: nil)
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                
            }
        }
    }
}

//MARK:- Extension Of CheckoutConfirmationViewController
extension CheckoutConfirmationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsInCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = checkoutTableView.dequeueReusableCell(withIdentifier: "ConfirmationCell", for: indexPath as IndexPath) as! ConfirmationTableViewCell
        let cartItem = self.cartItems[indexPath.row]
        let cartProduct: Product = self.productsInCart[indexPath.row]
        cell.displayProducts(cartProduct: cartItem, product: cartProduct)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}
//MARK:- End
