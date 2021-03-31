
//MARK:- Start
import UIKit

class CheckoutDetailViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var yourDetailsLabel: UILabel!
    @IBOutlet weak var emailAddressView: UIView!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var continueToPaymentButton: UIButton!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Button Actions
    @IBAction func continueToPaymentButtonTapped(_ sender: UIButton) {
        MoltinProducts.instance().createCustomer(userName: self.nameTextField?.text ?? "", userEmail: self.emailAddressTextField?.text ?? "")
        
        let storyBoard = UIStoryboard.init(name: "CheckoutFlow", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CheckoutPayment") as?
        CheckoutPaymentViewController
        
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "CheckoutFlow", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CartView") as?
        CartViewController
        self.present(vc!, animated: true, completion: nil)
    }
}
//MARK:- End
