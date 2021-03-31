
//MARK:- Start
import UIKit
import moltin

class ReceiptTableViewCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var receiptTableViewCellView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:- User-Defined Function
    func displayProducts(cartProduct: moltin.CartItem, product: moltin.Product) {
        self.productName.text = cartProduct.name
        self.productAmount.text = cartProduct.meta.displayPrice.withTax.value.formatted
        self.productImage.load(urlString: product.mainImage?.link["href"] ?? "")
    }
}
//MARK:- End
