
//MARK:- Start
import UIKit
import moltin

class MoltinProducts1 {
    
    //MARK:- Variables Declaration
    var category1Products: [Product] = []
    var category2Products: [Product] = []
    var category3Products: [Product] = []
    var category4Products: [Product] = []
    
    //MARK:- User-Defined Function
    func Products() {
        
        //Moltin Category 1
        MoltinProducts.instance().getProductsByCategory(categoryId: "bc36706b-e485-422b-abbc-38c127ac4171")
        { (products) in
            self.category1Products = products
        }
        
        //Moltin Category 2
        MoltinProducts.instance().getProductsByCategory(categoryId: "ce38108a-13e4-48df-8cfa-7475a024770c")
        { (products) in
            self.category2Products = products
        }
        
        //Moltin Category 3
        MoltinProducts.instance().getProductsByCategory(categoryId: "d5fce398-20a5-4575-9d84-c93ea6858781")
        { (products) in
            self.category3Products = products
        }
        
        //Moltin Category 4
        MoltinProducts.instance().getProductsByCategory(categoryId: "d5fce398-20a5-4575-9d84-c93ea6858781")
        { (products) in
            self.category3Products = products
        }
    }
}
//MARK:- End

