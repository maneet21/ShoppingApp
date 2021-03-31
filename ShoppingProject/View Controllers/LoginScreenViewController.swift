
//MARK:- Start
import UIKit

class LoginScreenViewController: UIViewController {
    
    //MARK:- Variable And Constants Declaration
    var isSelected1: Bool = true
    let defaultColor = UIColor.systemBlue
    let defaultColor1 = UIColor(red: 34/255, green: 27/255, blue: 153/255, alpha: 1)
    
    //MARK:- Outlets
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var showOrHidePasswordButton: UIButton!
    @IBOutlet weak var newUserSignUpButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    //MARK:- Button Actions
    @IBAction func showOrHidePasswordButtonTapped(_ sender: UIButton) {
        if isSelected1 {
            isSelected1 = false
            passwordTextField.isSecureTextEntry = false
        }
        else {
            isSelected1 = true
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
       
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10.0
        loginButton.layer.borderWidth = 1.0
        loginButton.layer.borderColor = defaultColor.cgColor
        forgotPasswordButton.layer.cornerRadius = 10.0
        forgotPasswordButton.layer.borderWidth = 1.0
        forgotPasswordButton.layer.borderColor = defaultColor.cgColor
        showOrHidePasswordButton.layer.cornerRadius = 10.0
        showOrHidePasswordButton.layer.borderWidth = 1.0
        showOrHidePasswordButton.layer.borderColor = defaultColor.cgColor
        newUserSignUpButton.layer.cornerRadius = 10.0
        newUserSignUpButton.layer.borderWidth = 1.0
        newUserSignUpButton.layer.borderColor = defaultColor.cgColor
        
        nameTextField.layer.cornerRadius = 5.0
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.borderColor = defaultColor1.cgColor
       
        passwordTextField.layer.cornerRadius = 5.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = defaultColor1.cgColor
    }
}
//MARK:- End
