
//MARK:- Start
import UIKit
import moltin

class ReceiptViewController: UIViewController {

    //MARK:- Variables Declaration
    var cartItems: [moltin.CartItem] = Array()
    var productsInCart: [moltin.Product] = Array()

    //MARK:- Outlets
    @IBOutlet weak var receiptTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var homeButton: UIButton!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MoltinProducts.instance().getCartItems(cartId: "") { (CartItems) -> (Void) in
            self.cartItems = CartItems
            let productIds = self.cartItems.map({ $0.productId })
            
            for id in productIds {
                MoltinProducts.instance().getProductById(productId: id ?? "") { (product) -> (Void) in
                    let productItem = product
                    self.productsInCart.insert(productItem!, at: self.productsInCart.endIndex)
                    self.receiptTableView.reloadData()
                }
            }
        }
        
        MoltinProducts.instance().getCart(cartId: "") { (cart) -> (Void) in
            self.amountLabel.text = cart?.meta?.displayPrice.withTax.formatted
        }
        
        receiptTableView.register(UINib(nibName: "ReceiptTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceiptCell")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        MoltinProducts.instance().deleteCart(cartId: "") { () -> (Void) in
            print("Cart removed")
        }
    }

    //MARK:- Button Action
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let hvc = storyBoard.instantiateViewController(withIdentifier: "CatalogView") as? CatalogViewController
        self.present(hvc!, animated: true, completion: nil)
    }
}

//MARK:- Extension Of ReceiptViewController
extension ReceiptViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsInCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = receiptTableView.dequeueReusableCell(withIdentifier: "ReceiptCell", for: indexPath as IndexPath) as! ReceiptTableViewCell
        let cartItem = self.cartItems[indexPath.row]
        let cartProduct: Product = self.productsInCart[indexPath.row]
        cell.displayProducts(cartProduct: cartItem, product: cartProduct)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
}
//MARK:- End
