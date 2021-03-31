
//MARK:- Start
import UIKit
import moltin

class MoltinProducts: NSObject {

    //MARK:- Constant And Variables Declaration
    let moltin: Moltin = Moltin(withClientID: AppDelegate.moltinId)
    var category: moltin.Category?
    var Products: [Product] = []
    var product: Product?
    var cart: moltin.Cart?
    var cartItems: [moltin.CartItem] = []
    static var instanceVar = MoltinProducts()
    
    private override init() {
        super.init();
    }
    
    //MARK:- User-Defined Functions
    static func instance() -> MoltinProducts {
        return instanceVar
    }

    //MARK:- Products
    
    //Get Products
    public func getProducts(completion: @escaping (_ products: [Product])  -> (Void)) {
        self.moltin.product.include([.mainImage]).sort("name").all { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.Products = response.data ?? []
                    completion(self.Products)
                }
            case .failure(let error):
                print("Prints error \(error)")
            }
        }
    }
    
    //Get Products Id
    public func getProductById(productId: String, completion: @escaping (_ product: Product?) -> (Void)) {
        self.moltin.product.include([.mainImage]).get(forID: productId, completionHandler: { (result: Result<Product>) in
            switch result {
            case .success(let product):
                DispatchQueue.main.async {
                    self.product = product
                    completion(self.product)
                }
            default:break
            }
        })
    }
    
    //Get Products By Category
    public func getProductsByCategory(categoryId: String , completion: @escaping (_ product: [moltin.Product]) -> (Void)) {
        self.moltin.product.filter(operator: .equal, key: "category.id", value: categoryId).include([.mainImage]).all
            { (result: Result<PaginatedResponse<[moltin.Product]>>) in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.Products = response.data ?? []
                        completion(self.Products)
                    }
                case .failure(let error):
                    print("Get Products error:", error)
                }
        }
    }
    
    //MARK:- Categories
    
    //Get Category By Id
    public func getCategoryById(categoryId: String, completion: @escaping (_ category: moltin.Category?) -> (Void)) {
        
        self.moltin.category.get(forID: categoryId, completionHandler: { (result: Result<moltin.Category>) in
            switch result {
            case .success(let category):
                DispatchQueue.main.async {
                    self.category = category
                    completion(self.category)
                }
            default:break
            }
        })
    }

    //MARK:- Cart
    
    //Add Item To Cart
    public func addItemToCart(cartId: String, productId: String, quantity: Int, completion: @escaping(_ itemAdded: Bool) -> (Void)) {
        var itemAdded = false
        self.moltin.cart.addProduct(withID: productId, ofQuantity: quantity, toCart: AppDelegate.cartID, completionHandler: { (_) in
            DispatchQueue.main.async {
                itemAdded = true
                completion(itemAdded)
            }
        })
    }
    
    //Remove Item From Cart
    public func removeItemFromCart(cartId: String?, productId: String, completion: @escaping() -> (Void)) {
       self.moltin.cart.removeItem(productId, fromCart: AppDelegate.cartID, completionHandler: { (_) in
        completion()
       })
    }
    
    //Get Cart Items
    public func getCartItems(cartId: String?, completion: @escaping ([moltin.CartItem]) -> (Void)) {
        self.moltin.cart.include([.products]).items(forCartID: AppDelegate.cartID) { (result) in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.cartItems = result.data ?? []
                    completion(self.cartItems)
                }
            case .failure(let error):
                print("Cart error:", error)
            }
        }
    }
    
    //Get Cart
    public func getCart(cartId: String, completion: @escaping (moltin.Cart?) -> (Void)) {
        self.moltin.cart.get(forID: AppDelegate.cartID, completionHandler: { (result) in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.cart = result
                    completion(self.cart)
                }
            case .failure(let error):
                print("Cart error:", error)
            }
        })
    }
    
    //Delete Cart
    public func deleteCart(cartId: String?, completion: @escaping () -> (Void)) {
        self.moltin.cart.deleteCart(AppDelegate.cartID, completionHandler: { (result) in
            switch result {
            case .success(let result):
                completion()
                print("Cart Error", result)
            case .failure(let error):
                completion()
                print("Cart Error", error)
            }
        })
    }
    
    //MARK:- Customer
    
    //Create Customer
    public func createCustomer(userName: String, userEmail: String) {
        var token: String = ""
        
        struct moltinToken: Codable {
            var clientId: String
            var token: String
            var expires: Date
        }
    
        if let data = UserDefaults.standard.value(forKey: "moltin.auth.credentials") as? Data {
            let credentials = try? JSONDecoder().decode(moltinToken.self, from: data)
            token = credentials?.token ?? ""
        }
        
        let headers = [
            "Accept": "Application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        let user = [ "data": [
            "type": "customer",
            "name": userName,
            "Email": userEmail,
            "password": "12345"
        ]] as [String: Any]
        
        let userData: Data
        do {
            userData = try JSONSerialization.data(withJSONObject: user, options: [])
        } catch {
            print("Error: Cannot create JSON from todo")
            return
        }
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.moltin.com/v2/customers")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = userData
        
        let Session = URLSession.shared
        let dataTask = Session.dataTask(with: request as URLRequest, completionHandler: { (data, response , error) -> Void in
            
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse as Any)
            }
        })
        dataTask.resume()
    }
    
    //MARK:- Orders
    
    //Pay For Order
    public func payForOrder(order: Order?, paymentMethod: PaymentMethod, completion: @escaping(_ orderPayed: Bool) -> (Void)) {
        var OrderPayed = false
        self.moltin.cart.pay(forOrderID: order?.id ?? "", withPaymentMethod: paymentMethod) { (result) in
            switch result {
            case .success(let status):
                DispatchQueue.main.async {
                    OrderPayed = true
                    completion(OrderPayed)
                    print("Paid for order:\(status)")
                }
            case .failure(let error):
                OrderPayed = false
                completion(OrderPayed)
                print("Could not pay for order: \(error)")
            }
        }
    }

    //Checkout Order
    public func checkoutOrder(customer: Customer, address: Address, completion: @escaping  (_ Order: Order) -> (Void)) {
        self.moltin.cart.checkout(cart: AppDelegate.cartID, withCustomer: customer, withBillingAddress: address, withShippingAddress: nil) { (result) in
            switch result {
            case .success(let order):
                DispatchQueue.main.async {
                    completion(order)
                }
            default: break
            }
        }
    }
    
    //MARK:- Promotions
    
    //Apply Promotion
    public func applyPromotion(code: String, completion: @escaping (_ promotionWorked: Bool) -> (Void)) {
        self.moltin.cart.addPromotion(code, toCart: AppDelegate.cartID) { (result) in
            var promortionWorked = false
            switch result {
            case .success(let status):
                DispatchQueue.main.async {
                    promortionWorked = true
                    completion(promortionWorked)
                    print("Promotion: \(status)")
                }
            default: break
            }
        }
    }
}
//MARK:- End

