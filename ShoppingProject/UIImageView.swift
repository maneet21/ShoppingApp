
//MARK:- Start
import Foundation
import UIKit

extension UIImageView {
    
    //MARK:- User-Defined Function
    func load(urlString string: String?) {
        guard let imageUrl = string,
        let url = URL(string: imageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
//MARK:- End
