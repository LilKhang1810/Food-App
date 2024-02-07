
import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
class ProductViewController:ObservableObject{
    @Published var products: [Product] = []
    private let db = Firestore.firestore()
    private let uId = Auth.auth().currentUser?.uid
    @State var showingAlert: Bool = false
    @State var messageAlert = ""
    @State var titleAlert = ""
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
    func addToCart(item: Product, optionPrice: Int,quantity: Int) async{
        guard let uId else{
            return
        }
        let newId  = UUID().uuidString
        let cartProduct = Product(id: item.id,
                                  name: item.name,
                                  price: (item.price + optionPrice)*quantity,
                                  img_url: item.img_url,
                                  brand: item.brand,
                                  popular: item.popular,
                                  type: item.type,
                                  quantity: quantity)
        do{
            let cartItem = db.collection("User").document(uId).collection("Cart")
            if let existingItem = try await cartItem.whereField("name", isEqualTo: item.name).getDocuments().documents.first{
                
                let quantity = existingItem.data()["quantity"] as? Int ?? item.quantity
                try await existingItem.reference.updateData(["quantity": quantity+1])
                //                showAlert(title: "Added to bag", message: "Your shoe is added to bag successfully")
                
                
            }
            else{
                let documentRef = cartItem.document(newId)
                try await documentRef.setData(cartProduct.asDictionary())
                //                showAlert(title: "Added to bag", message: "Your shoe is added to bag successfully")
            }
        }
        catch {
            print("Error adding/updating document: \(error)")
        }
    }
    func addToFav(item: Product) async{
        guard let uId else{
            return
        }
        let newId  = UUID().uuidString
        let cartProduct = Product(id: item.id,
                                  name: item.name,
                                  price: item.price,
                                  img_url: item.img_url,
                                  brand: item.brand,
                                  popular: item.popular,
                                  type: item.type)
        do{
            let cartItem = db.collection("User").document(uId).collection("Fav")
            if let existingItem = try await cartItem.whereField("name", isEqualTo: item.name).getDocuments().documents.first{
                showAlert(title: "Already Added", message: "Your fav dish has already in your fav")
                
            }
            else{
                let documentRef = cartItem.document(newId)
                try await documentRef.setData(cartProduct.asDictionary())
                //                showAlert(title: "Added to bag", message: "Your shoe is added to bag successfully")
            }
        }
        catch {
            print("Error adding/updating document: \(error)")
        }
    }
    func showAlert(title: String, message: String){
        titleAlert = title
        messageAlert = message
        showingAlert = true
    }
}
