
//MARK:- Start
import UIKit
import moltin

class ConfirmationTableViewCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var confirmationTableViewCellView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productAmount: UILabel!
    @IBOutlet weak var productSize: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:- User-Defined Function
    func displayProducts(cartProduct: moltin.CartItem, product: moltin.Product) {
        self.productName.text = cartProduct.name
        self.productAmount.text = cartProduct.meta.displayPrice.withTax.value.formatted
        self.productQuantity.text = String(cartProduct.quantity)
        self.productImage.load(urlString: product.mainImage?.link["href"] ?? "")
    }
}
//MARK:- End
