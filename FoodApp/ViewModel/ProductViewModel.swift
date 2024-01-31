
import Foundation
import SwiftUI
import Firebase

class ProductViewController:ObservableObject{
    @Published var products: [Product] = []
    private let db = Firestore.firestore()
    init(){
        print("Init ProductViewController")
        fetchProduct()
    }
    func fetchProduct(){
        let ref = db.collection("Product ")
        ref.getDocuments{ snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    let id = document.documentID
                    let brand = data["brand"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let img_url = data["img_url"] as? String ?? ""
                    let price = data["price"] as? Int ?? 0
                    let popular = data["popular"] as? Bool ?? false
                    let type = data["type"] as? String ?? ""
                    let product = Product(id: id, name: name, price: price, img_url: img_url, brand: brand,popular: popular,type: type)
                    self.products.append(product)
                }
            }
        }
    }
    
}
