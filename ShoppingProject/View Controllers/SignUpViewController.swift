
//MARK:- Start
import UIKit

class SignUpViewController: UIViewController {
    
    //MARK:- Variable And Constants Declaration
    var isSelected1: Bool = false
    let defaultColor = UIColor.systemBlue
    let defaultColor1 = UIColor(red: 34/255, green: 27/255, blue: 153/255, alpha: 1)
    
    //MARK:- Outlets
    @IBOutlet weak var signUpLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var homeButton: UIButton!
    
    //MARK:- Button Actions
    @IBAction func checkmarkButtonTapped(_ sender: UIButton) {
        if isSelected1 {
            isSelected1 = false
            checkmarkButton.backgroundColor = UIColor.white
            checkmarkButton.setImage(UIImage(named: ""), for: .normal)
        }
        else {
            isSelected1 = true
            checkmarkButton.isHidden = false
            checkmarkButton.backgroundColor = UIColor.blue
            checkmarkButton.setImage(UIImage(named: "CheckmarkImage"), for: .normal)
           // checkmarkButton.
        }
    }
 
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        if firstNameTextField.text != "" && lastNameTextField.text != "" && emailAddressTextField.text != "" && ageTextField.text != "" && mobileNumberTextField.text != "" && passwordTextField.text != "" && confirmPasswordTextField.text != "" && checkmarkButton.currentImage == UIImage(named: "CheckmarkImage")    {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ConfirmationViewController") as!
            ConfirmationViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.layer.cornerRadius = 5.0
        confirmButton.layer.borderWidth = 1.0
        confirmButton.layer.borderColor = defaultColor.cgColor
        
   /*     firstNameTextField.layer.cornerRadius = 5.0
        firstNameTextField.layer.borderWidth = 1.0
        firstNameTextField.layer.borderColor = defaultColor1.cgColor
        
        lastNameTextField.layer.cornerRadius = 5.0
        lastNameTextField.layer.borderWidth = 1.0
        lastNameTextField.layer.borderColor = defaultColor1.cgColor
        
        emailAddressTextField.layer.cornerRadius = 5.0
        emailAddressTextField.layer.borderWidth = 1.0
        emailAddressTextField.layer.borderColor = defaultColor1.cgColor
        
        ageTextField.layer.cornerRadius = 5.0
        ageTextField.layer.borderWidth = 1.0
        ageTextField.layer.borderColor = defaultColor1.cgColor
        
        mobileNumberTextField.layer.cornerRadius = 5.0
        mobileNumberTextField.layer.borderWidth = 1.0
        mobileNumberTextField.layer.borderColor = defaultColor1.cgColor
        
        passwordTextField.layer.cornerRadius = 5.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = defaultColor1.cgColor
        
        confirmPasswordTextField.layer.cornerRadius = 5.0
        confirmPasswordTextField.layer.borderWidth = 1.0
        confirmPasswordTextField.layer.borderColor = defaultColor1.cgColor */
        
        checkmarkButton.layer.cornerRadius = 1.0
        checkmarkButton.layer.borderWidth = 1.0
        checkmarkButton.layer.borderColor = defaultColor1.cgColor
    }
}
//MARK:- End
