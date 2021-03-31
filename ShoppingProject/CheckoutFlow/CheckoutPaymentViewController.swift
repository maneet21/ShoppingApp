
//MARK:- Start
import UIKit
import moltin
import PassKit

class CheckoutPaymentViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var applyAPromoCodeLabel: UILabel!
    @IBOutlet weak var applyAPromoCodeView: UIView!
    @IBOutlet weak var applyAPromoCodeTextField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var chooseAPaymentMethodLabel: UILabel!
    @IBOutlet weak var applePayButton: UIButton!
    @IBOutlet weak var applePayLabel: UILabel!
    @IBOutlet weak var applePayCheckmark: UIImageView!
    @IBOutlet weak var creditCardButton: UIButton!
    @IBOutlet weak var creditCardLabel: UILabel!
    @IBOutlet weak var creditCardCheckmark: UIImageView!
    @IBOutlet weak var cardDetailsLabel: UILabel!
    @IBOutlet weak var cardDetailsView: UIView!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardExpiryDateTextField: UITextField!
    @IBOutlet weak var cardCVVTextField: UITextField!
    @IBOutlet weak var orderConfirmationButton: UIButton!
    
    //MARK:- Constants And Variables Declaration
    let supportedPaymentNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex]
    let ApplePaySwagMerchantId = "2286509828052353211"
    var applePay: Bool = false
    
    var CustomerName: String = "Maneet"
    var CustomerEmail: String = "maneet210@gmail.com"
    var FirstName: String = "Maneet"
    var LastName: String = "Singh"
    
    var cartItems: [moltin.CartItem] = Array()
    var cart: moltin.Cart?
    var order: moltin.Order?
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Button Actions
    @IBAction func applePayButtonTapped(_ sender: UIButton) {
        self.creditCardButton.isHidden = true
        self.creditCardCheckmark.isHidden = true
        self.creditCardLabel.isHidden = true
        self.cardDetailsLabel.isHidden = true
        self.cardDetailsView.isHidden = true
        self.cardNumberTextField.isHidden = true
        self.cardExpiryDateTextField.isHidden = true
        self.cardCVVTextField.isHidden = true
        self.applePay = true
        
        self.applePayCheckmark.isHidden = false
    }
    
    @IBAction func creditCardButtonTapped(_ sender: UIButton) {
        self.applePayCheckmark.isHidden = true
        self.applePay = false
        
        self.creditCardButton.isHidden = false
        self.cardNumberTextField.isHidden = false
        self.cardExpiryDateTextField.isHidden = false
        self.cardCVVTextField.isHidden = false
        self.cardDetailsView.isHidden = false
        self.cardDetailsLabel.isHidden = false
    }

    @IBAction func applyButtonTapped(_ sender: UIButton) {
        MoltinProducts.instance().applyPromotion(code: applyAPromoCodeTextField.text ?? "") { (promotionWorked) -> (Void) in
            let title = promotionWorked ? "Discount applied" : "Discount did not apply"
            let message = promotionWorked ? "Continue to the next page to see your updated order and complete the purchase" : "Promo code did not apply"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (action) in }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func orderConfirmationButtonTapped(_ sender: UIButton) {
        
        let customer = Customer(withEmail: CustomerEmail, withName: CustomerName)
        let address = Address(withFirstName: FirstName, withLastName: LastName)
        
        address.line1 = "123"
        address.country = "India"
        address.county = "Punjab"
        address.city = "Mohali"
        address.postcode = "1234"
        
        MoltinProducts.instance().checkoutOrder(customer: customer, address: address) { (Order) -> (Void) in
            self.order = Order
            
            if self.applePay {
                let request = PKPaymentRequest()
                
                request.countryCode = "IND"
                request.currencyCode = "Rs"
                request.merchantCapabilities = PKMerchantCapability.capability3DS
                request.supportedNetworks = self.supportedPaymentNetworks
                request.merchantIdentifier = self.ApplePaySwagMerchantId
                request.requiredBillingContactFields = [.name, .postalAddress]
                
                let applePayFormatter = NumberFormatter()
                applePayFormatter.usesGroupingSeparator = true
                applePayFormatter.numberStyle = .decimal
                
                let product = PKPaymentSummaryItem(label: "Product", amount: NSDecimalNumber(decimal: Decimal(self.cartItems[0].meta.displayPrice.withTax.value.amount/100)), type: .final)
                
                let shipping = PKPaymentSummaryItem(label: "Shipping", amount: NSDecimalNumber(decimal: 1.00), type: .final)
                
                let tax = PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(decimal: 3.00), type: .final)
                
                let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(decimal: Decimal((self.cart?.meta?.displayPrice.withTax.amount)!/100)), type: .final)
                
                request.paymentSummaryItems = [product, shipping, tax, total]
                let ApplePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
                ApplePayController?.delegate = self
                
                self.present(ApplePayController!, animated: true, completion: nil)
            }
                
            else {
                let storyBoard = UIStoryboard(name: "CheckoutFlow", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "CheckoutConfirmation") as!
                CheckoutConfirmationViewController
                vc.orderId = Order
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}

//MARK:- Extension Of CheckoutPaymentViewController
extension CheckoutPaymentViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    private func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping ((PKPaymentAuthorizationStatus) -> Void)) {
        completion(PKPaymentAuthorizationStatus.success)
        
        let paymentMethod = ManuallyAuthorizePayment()
        
        MoltinProducts.instance().payForOrder(order: self.order!, paymentMethod: paymentMethod) {
            (paymentWorked) -> (Void) in
            if paymentWorked {
                print("Payment worked", self.order!)
            }
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        let storyBoard = UIStoryboard.init(name: "CheckoutFlow", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Receipt") as! ReceiptViewController
        
        self.present(vc, animated: true, completion: nil)
    }
}
//MARK:- End
