
//MARK:- Start
import UIKit

class CollectionCatalogViewCell: UICollectionViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var collectionCatalogViewCellLabel: UILabel!
    @IBOutlet weak var collectionCatalogViewCellImage: UIImageView!
    @IBOutlet weak var collectionCatalogViewCellPriceLabel: UILabel!
    
    @IBOutlet weak var stepper1: UIStepper!
    @IBOutlet weak var stepper2: UIStepper!
    @IBOutlet weak var stepper3: UIStepper!
    @IBOutlet weak var stepper4: UIStepper!

    @IBOutlet weak var stepper1Label: UILabel!
    @IBOutlet weak var stepper2Label: UILabel!
    @IBOutlet weak var stepper3Label: UILabel!
    @IBOutlet weak var stepper4Label: UILabel!
    
    //MARK:- Button Actions
    @IBAction func stepper1ValueChanged(_ sender: UIStepper) {
        stepper1Label.text = Int(sender.value).description
    }
    
    @IBAction func stepper2ValueChanged(_ sender: UIStepper) {
        stepper2Label.text = Int(sender.value).description
    }
    
    @IBAction func stepper3ValueChanged(_ sender: UIStepper) {
        stepper3Label.text = Int(sender.value).description
    }
    
    @IBAction func stepper4ValueChanged(_ sender: UIStepper) {
        stepper4Label.text = Int(sender.value).description
    }

    //MARK:- User-Defined Function
    func displayCatalogProducts(name: String, image: String, price: String) {
        self.collectionCatalogViewCellLabel.text = name
        self.collectionCatalogViewCellImage.load(urlString: image)
        self.collectionCatalogViewCellPriceLabel.text = price
    }
}
//MARK:- End
