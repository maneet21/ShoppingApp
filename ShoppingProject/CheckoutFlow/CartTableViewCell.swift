
//MARK:- Start
import UIKit
import moltin

//MARK:- Protocol
protocol CartTableViewCellDelegate: class {
    func DeleteButtonTappedFunction(_ sender: CartTableViewCell)
    func ProductQuantityButtonTappedFunction(_ sender: CartTableViewCell)
}

class CartTableViewCell: UITableViewCell {
    
    //MARK:- Variables Declaration
    weak var delegate: CartTableViewCellDelegate?
    var cartCellItem: moltin.CartItem?
    var productCellItem: moltin.Product?
    
    //MARK:- Outlets
    @IBOutlet weak var cartTableViewCellView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDetail: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var productQuantity: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:- User-Defined Function
    func displayProducts(cartProduct: moltin.CartItem, product: moltin.Product)  {
        self.cartCellItem = cartProduct
        self.productCellItem = product
        
        self.productQuantity.setTitle("x \(String(cartProduct.quantity))", for: .normal)        
        self.productName.text = cartProduct.name
        self.productDetail.text = cartProduct.description
        self.productPrice.text = cartProduct.meta.displayPrice.withTax.value.formatted
        self.productImage.load(urlString: product.mainImage?.link["href"] ?? "")
    }
    
    //MARK:- Button Actions
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delegate?.DeleteButtonTappedFunction(self)
    }
    
    @IBAction func productQuantityButtonTapped(_ sender: UIButton) {
        delegate?.ProductQuantityButtonTappedFunction(self)
    }
}
//MARK:- End
