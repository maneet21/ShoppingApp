
//MARK:- Start
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    //MARK:- User-Defined Function
    func DisplayProducts(name: String, image: String) {
        self.cellLabel.text = name
        self.cellImage.load(urlString: image)
    }
}
//MARK:- End
