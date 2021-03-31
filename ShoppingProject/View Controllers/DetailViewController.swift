
//MARK:- Start
import UIKit
import moltin

class DetailViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var labelSelectedIndex: UILabel!
    @IBOutlet weak var labelSelectedDescription: UILabel!
    @IBOutlet weak var labelSelectedPrice: UILabel!
    @IBOutlet weak var imageSelected: UIImageView!
    @IBOutlet weak var stepper1: UIStepper!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var shoppingCartButton: UIButton!
    
    //MARK:- Variables And Constants Declaration
    var SelectedIndex = ""
    var Selected = #imageLiteral(resourceName: "iPadMiniImage")
    var SelectedStepper = 0
    var product: Product?
    let defaultColor = UIColor(red: 34/255, green: 27/255, blue: 153/255, alpha: 1)
    let moltin: Moltin = Moltin(withClientID: "G7keyhEB7YLzb3QsnYZg65eU1q0wQDukLeB9fUadSQ", withLocale: Locale(identifier: "en_US"))
  
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageSelected.load(urlString: self.product?.mainImage?.link["href"] ?? "")
        self.labelSelectedIndex.text = product?.name
        self.labelSelectedDescription.text = product?.description
        self.labelSelectedPrice.text = product?.meta.displayPrice?.withoutTax.formatted

        stepper1.wraps = true
        stepper1.autorepeat = true
        stepper1.maximumValue = 10
        stepper1.layer.cornerRadius = 10.0
        stepper1.layer.borderWidth = 0.5
        stepper1.layer.borderColor = defaultColor.cgColor
        
        addToCartButton.layer.cornerRadius = 5.0
        addToCartButton.layer.borderWidth = 0.5
        addToCartButton.layer.borderColor = defaultColor.cgColor
        
        doneButton.layer.cornerRadius = 5.0
        doneButton.layer.borderWidth = 0.5
        doneButton.layer.borderColor = defaultColor.cgColor
        
        resetButton.layer.cornerRadius = 5.0
        resetButton.layer.borderWidth = 0.5
        resetButton.layer.borderColor = defaultColor.cgColor
    }
    
    //MARK:- Button Actions
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        stepperLabel.text = String(Int(stepper1.value))
        stepper1.isEnabled = false
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        stepper1.value = 0.0
        stepperLabel.text = "0"
        stepper1.isEnabled = true
    }
    
    @IBAction func shoppingCartButtonTapped(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "CheckoutFlow", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CartView") as!
        CartViewController
        if stepperLabel.text != "0" {
            
        }
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        stepperLabel.text = Int(sender.value).description
    }
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        MoltinProducts.instance().addItemToCart(cartId: "", productId: product?.id ?? "", quantity: 1) {
            (itemAdded) -> (Void) in
            if itemAdded {
                let storyBoard = UIStoryboard(name: "CheckoutFlow", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CartView") as!
                CartViewController
                self.present(nextViewController, animated: true, completion: nil)
            }
            else {
                
            }
        }
    }
}
//MARK:- End
