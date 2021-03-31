
//MARK:- Start
import UIKit

class PasswordResetViewController: UIViewController {
    
    //MARK:- Constants Declaration
    let defaultColor = UIColor.systemBlue
    let defaultColor1 = UIColor(red: 34/255, green: 27/255, blue: 153/255, alpha: 1)
    
    //MARK:- Outlets
    @IBOutlet weak var passwordRecoveryOrResetLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    //MARK:- Button Actions
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        if emailAddressTextField.text != "" {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyboard.instantiateViewController(withIdentifier: "Confirmation1ViewController" ) as! Confirmation1ViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.layer.cornerRadius = 10.0
        confirmButton.layer.borderWidth = 1.0
        confirmButton.layer.borderColor = defaultColor.cgColor
        
        emailAddressTextField.layer.cornerRadius = 5.0
        emailAddressTextField.layer.borderWidth = 1.0
        emailAddressTextField.layer.borderColor = defaultColor1.cgColor
    }
}
//MARK:- End
