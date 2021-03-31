
//MARK:- Start
import UIKit
import moltin

class CartViewController: UIViewController {
    
    //MARK:- Variables Declaration
    var cartItems: [moltin.CartItem] = Array()
    var productsInCart: [moltin.Product] = Array()
    
    //MARK:- Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountInCartLabel: UILabel!
    @IBOutlet weak var cartDetailView: UIView!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var keepShoppingButton: UIButton!
    @IBOutlet weak var checkoutButton: UIButton!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        
        //Moltin Get Cart
        MoltinProducts.instance().getCart(cartId: "") { (Cart) -> (Void) in
            self.amountLabel.text = "Subtotal: \(Cart?.meta?.displayPrice.withTax.formatted ?? "")"
        }
        
        //Moltin Get Cart Items
        MoltinProducts.instance().getCartItems(cartId: "") { (cartItems) -> (Void) in
            self.cartItems = cartItems
            
            let productIds = self.cartItems.map({ $0.productId })
            
            for id in productIds {
                MoltinProducts.instance().getProductById(productId: id ?? "") { (product) -> (Void) in
                    let productItem = product
                    self.productsInCart.insert(productItem!, at: self.productsInCart.endIndex)
                  
                    DispatchQueue.main.async {
                        self.cartTableView.reloadData()
                    }
                }
            }
            self.amountInCartLabel.text = String(self.cartItems.count)
        }
    }
    
    //MARK:- Button Actions
    @IBAction func keepShoppingButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CatalogView") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func checkoutButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "CartToCheckoutDetail", sender: nil)
    }
}

//MARK:- Extension Of CartViewController
extension CartViewController: UITableViewDataSource, UITableViewDelegate, CartTableViewCellDelegate {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsInCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath as IndexPath) as!
        CartTableViewCell
        let cartItem = self.cartItems[indexPath.row]
        let cartProduct: Product = self.productsInCart[indexPath.row]
        cell.delegate = self
        cell.displayProducts(cartProduct: cartItem, product: cartProduct)
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = "Click Checkout to test order"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: title, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
        
    func DeleteButtonTappedFunction(_ sender: CartTableViewCell) {
        guard let tappedIndexPath = cartTableView.indexPath(for: sender) else { return }
        
        //Moltin Remove Item From Cart
        MoltinProducts.instance().removeItemFromCart(cartId: "", productId: self.cartItems[tappedIndexPath.row].id) { () -> (Void) in
          
           DispatchQueue.main.async {
                self.cartTableView.reloadData()
            }
        }
          
        self.productsInCart.remove(at: tappedIndexPath.row)
        self.cartItems.remove(at: tappedIndexPath.row)
       
        self.cartTableView.deleteRows(at: [tappedIndexPath], with: .automatic)
    
        //Moltin Get Cart Items
        MoltinProducts.instance().getCartItems(cartId: "") { (cartItems) in
            self.cartItems = cartItems
            self.amountInCartLabel.text = String(self.cartItems.count)
            
            //Moltin Get Cart
            MoltinProducts.instance().getCart(cartId: "") { (Cart) in
                self.amountLabel.text = "Subtotal: \(Cart?.meta?.displayPrice.withTax.formatted ?? "")"
            }
            
            DispatchQueue.main.async {
                 self.cartTableView.reloadData()
            }
        }
    }
    
    func ProductQuantityButtonTappedFunction(_ sender: CartTableViewCell) {
        guard let tappedIndexPath = cartTableView.indexPath(for: sender) else { return }
        
        //Moltin Add Item To Cart
        MoltinProducts.instance().addItemToCart(cartId: "", productId: self.productsInCart[tappedIndexPath.row].id, quantity: 1) { (ItemAdded) -> (Void) in
            
            if ItemAdded {
                //Moltin Get Cart Items
                MoltinProducts.instance().getCartItems(cartId: "") { (cartItems) -> (Void) in
                    self.cartItems = cartItems
                    self.amountInCartLabel.text = String(self.cartItems.count)
                    
                    //Moltin Get Cart
                    MoltinProducts.instance().getCart(cartId: "") { (Cart) -> (Void) in
                        self.amountLabel.text = "Subtotal: \(Cart?.meta?.displayPrice.withTax.formatted ?? "")"
                    }
                    
                    DispatchQueue.main.async {
                        self.cartTableView.reloadData()
                    }
                }
            }
        }
    }
}
//MARK:- End
