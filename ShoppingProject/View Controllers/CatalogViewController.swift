
//MARK:- Start
import UIKit
import moltin

class CatalogViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK:- Outlets
    @IBOutlet weak var categoryNameView1: UIView!
    @IBOutlet weak var categoryNameView2: UIView!
    @IBOutlet weak var categoryNameView3: UIView!
    @IBOutlet weak var categoryNameView4: UIView!
    
    @IBOutlet weak var catalogScrollView: UIScrollView!
    
    @IBOutlet weak var catalogCollectionView1: UICollectionView!
    @IBOutlet weak var catalogCollectionView2: UICollectionView!
    @IBOutlet weak var catalogCollectionView3: UICollectionView!
    @IBOutlet weak var catalogCollectionView4: UICollectionView!
    
    @IBOutlet weak var category1NameLabel: UILabel!
    @IBOutlet weak var category2NameLabel: UILabel!
    @IBOutlet weak var category3NameLabel: UILabel!
    @IBOutlet weak var category4NameLabel: UILabel!
    
    @IBOutlet weak var viewAll1: UIButton!
    @IBOutlet weak var viewAll2: UIButton!
    @IBOutlet weak var viewAll3: UIButton!
    @IBOutlet weak var viewAll4: UIButton!
    
    //MARK:- Constant And Variables Declaration
    let moltin: Moltin = Moltin(withClientID: "G7keyhEB7YLzb3QsnYZg65eU1q0wQDukLeB9fUadSQ")
    var categories: [moltin.Category] = []
    var product1: [Product] = []
    var category1Products: [Product] = []
    var category2Products: [Product] = []
    var category3Products: [Product] = []
    var category4Products: [Product] = []
    
    var Category1Name: moltin.Category!
    var Category2Name: moltin.Category!
    var Category3Name: moltin.Category!
    var Category4Name: moltin.Category!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = catalogCollectionView1.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize.height = 250
            layout.itemSize.width = 250
        }
               
        if let layout = catalogCollectionView2.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize.height = 250
            layout.itemSize.width = 250
        }
               
        if let layout = catalogCollectionView3.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        if let layout = catalogCollectionView4.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        categoryNameView1.layer.borderWidth = 1
        categoryNameView2.layer.borderWidth = 1
        categoryNameView3.layer.borderWidth = 1
        categoryNameView4.layer.borderWidth = 1
        
        //MARK:- Moltin Category 1
        MoltinProducts.instance().getProductsByCategory(categoryId: "bc36706b-e485-422b-abbc-38c127ac4171") { (products) in
             self.category1Products = products
             
             DispatchQueue.main.async {
                 self.catalogCollectionView1.reloadData()
             }
        }
        
        MoltinProducts.instance().getCategoryById(categoryId: "bc36706b-e485-422b-abbc-38c127ac4171") { (category) in
            self.Category1Name = category
            
            DispatchQueue.main.async {
                self.catalogCollectionView1.reloadData()
            }
        }
        
        //MARK:- Moltin Category 2
        MoltinProducts.instance().getProductsByCategory(categoryId: "ce38108a-13e4-48df-8cfa-7475a024770c") { (products) in
            
             self.category2Products = products
      
             DispatchQueue.main.async {
                 self.catalogCollectionView2.reloadData()
             }
        }
        
        MoltinProducts.instance().getCategoryById(categoryId: "ce38108a-13e4-48df-8cfa-7475a024770c") { (category) in
            self.Category2Name = category
            
            DispatchQueue.main.async {
                self.catalogCollectionView2.reloadData()
            }
        }
        
        //MARK:- Moltin Category 3
        MoltinProducts.instance().getProductsByCategory(categoryId: "d5fce398-20a5-4575-9d84-c93ea6858781") { (products) in
            
             self.category3Products = products
            
             DispatchQueue.main.async {
                 self.catalogCollectionView3.reloadData()
             }
        }
        
        MoltinProducts.instance().getCategoryById(categoryId: "d5fce398-20a5-4575-9d84-c93ea6858781") { (category) in
            self.Category3Name = category
            
            DispatchQueue.main.async {
                self.catalogCollectionView3.reloadData()
            }
        }
        
        //MARK:- Moltin Category 4
        MoltinProducts.instance().getProductsByCategory(categoryId: "5a9789a3-4310-4d2a-88b7-9e610dbbd53e") { (products) in
            
             self.category4Products = products
            
             DispatchQueue.main.async {
                 self.catalogCollectionView4.reloadData()
             }
        }
        
        MoltinProducts.instance().getCategoryById(categoryId: "5a9789a3-4310-4d2a-88b7-9e610dbbd53e") { (category) in
            self.Category4Name = category
            
            DispatchQueue.main.async {
                self.catalogCollectionView4.reloadData()
            }
        }
    }
    
    //MARK:- Collection View Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           if collectionView == self.catalogCollectionView1 {
               return self.category1Products.count
           }

           else if collectionView == self.catalogCollectionView2 {
               return self.category2Products.count
           }
            
           else if collectionView == self.catalogCollectionView3 {
               return self.category3Products.count
           }
            
           else {
               return self.category4Products.count
           }
     }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.catalogCollectionView1 {
            self.category1NameLabel.text = self.Category1Name?.name
            let cell1 = catalogCollectionView1.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            as! CollectionCatalogViewCell
            cell1.layer.borderWidth = 1
            cell1.layer.cornerRadius = 10
            cell1.displayCatalogProducts(name: self.category1Products[indexPath.row].name, image: self.category1Products[indexPath.row].mainImage?.link["href"] ?? "", price: self.category1Products[indexPath.row].meta.displayPrice?.withTax.formatted ?? "")
            return cell1
        }
           
        else if collectionView == self.catalogCollectionView2 {
            self.category2NameLabel.text = self.Category2Name?.name
            let cell2 = catalogCollectionView2.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            as! CollectionCatalogViewCell
            cell2.layer.borderWidth = 1
            cell2.layer.cornerRadius = 10
            cell2.displayCatalogProducts(name: self.category2Products[indexPath.row].name, image:  self.category2Products[indexPath.row].mainImage?.link["href"] ?? "", price: self.category2Products[indexPath.row].meta.displayPrice?.withTax.formatted ?? "" )
            return cell2
        }
            
        else if collectionView == self.catalogCollectionView3 {
            self.category3NameLabel.text = self.Category3Name?.name
            let cell3 = catalogCollectionView3.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            as! CollectionCatalogViewCell
            cell3.layer.borderWidth = 1
            cell3.layer.cornerRadius = 10
            cell3.displayCatalogProducts(name: self.category3Products[indexPath.row].name, image:  self.category3Products[indexPath.row].mainImage?.link["href"] ?? "", price: self.category3Products[indexPath.row].meta.displayPrice?.withTax.formatted ?? "" )
            return cell3
        }
           
        else {
            self.category4NameLabel.text = self.Category4Name?.name
            let cell4 = catalogCollectionView4.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            as! CollectionCatalogViewCell
            cell4.layer.borderWidth = 1
            cell4.layer.cornerRadius = 10
            cell4.displayCatalogProducts(name: self.category4Products[indexPath.row].name, image: self.category4Products[indexPath.row].mainImage?.link["href"] ?? "", price: self.category4Products[indexPath.row].meta.displayPrice?.withTax.formatted ?? "")
            return cell4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if collectionView == self.catalogCollectionView1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
            vc?.product =  self.category1Products[indexPath.row]
            self.present(vc!, animated: true, completion: nil)
        }
            
        else if collectionView == self.catalogCollectionView2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
            vc?.product =  self.category2Products[indexPath.row]
            self.present(vc!, animated: true, completion: nil)
        }
            
        else if collectionView == self.catalogCollectionView3 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
            vc?.product =  self.category3Products[indexPath.row]
            self.present(vc!, animated: true, completion: nil)
        }
            
        else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
            vc?.product =  self.category4Products[indexPath.row]
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    //MARK:- Button Actions
    @IBAction func viewAll1Tapped(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CollectionViewController") as!
        CollectionViewController
        nextViewController.productlist1 = self.category1Products
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    @IBAction func viewAll2Tapped(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CollectionViewController") as!
        CollectionViewController
        nextViewController.productlist1 = self.category2Products
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    @IBAction func viewAll3Tapped(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CollectionViewController") as!
        CollectionViewController
        nextViewController.productlist1 = self.category3Products
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    @IBAction func viewAll4Tapped(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CollectionViewController") as!
        CollectionViewController
        nextViewController.productlist1 = self.category4Products
        self.present(nextViewController, animated: true, completion: nil)
    }
}
//MARK:- End
