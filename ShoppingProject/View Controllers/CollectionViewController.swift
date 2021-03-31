
//MARK:- Start
import UIKit
import moltin

class CollectionViewController: UICollectionViewController {

    //MARK:- Constants And Variables Declaration
    let defaultColor = UIColor(red: 34/255, green: 27/255, blue: 153/255, alpha: 1)
    let moltin: Moltin = Moltin(withClientID: "G7keyhEB7YLzb3QsnYZg65eU1q0wQDukLeB9fUadSQ", withLocale: Locale(identifier: "en_US"))
    
    var product: [Product] = []
    var productlist1: [Product] = []
    
    //MARK:- Outlets
    @IBOutlet weak var shoppingCartButton: UIBarButtonItem!
    @IBOutlet var collectionView0: UICollectionView!
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Button Action
    @IBAction func shoppingCartButtonTapped(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "CheckoutFlow", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CartView") as!
        CartViewController
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    //MARK:- Collection View Data Source
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productlist1.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.layer.cornerRadius = 5.0
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = defaultColor.cgColor
        
        cell.DisplayProducts(name: self.productlist1[indexPath.row].name, image: self.productlist1[indexPath.row].mainImage?.link["href"] ?? "")
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.productlist1[indexPath.row]
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as!
        DetailViewController
        nextViewController.product = product
        self.present(nextViewController, animated: true, completion: nil)
    }
}
//MARK:- End
