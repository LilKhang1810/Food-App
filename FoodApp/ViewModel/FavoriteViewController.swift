//
//  FavoriteViewController.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 18/02/2024.
//

import Foundation
import FirebaseAuth
import Firebase
class FavoriteViewController: ObservableObject{
    @Published var foods:[Product] = []
    private var db = Firestore.firestore()
    private let uId = Auth.auth().currentUser?.uid
    @Published var showingAlert: Bool = false
    @Published var messageAlert = ""
    @Published var titleAlert = ""
    init(){
        fetchFavDB()
    }
    func fetchFavDB(){
        guard let uId else{
            return
        }
        let cartdb = db.collection("User").document(uId).collection("Fav")
        cartdb.addSnapshotListener { snapshot, error in
            guard error == nil else {
                return
            }
            if let snapshot = snapshot{
                self.foods = snapshot.documents.compactMap{ document in
                    let data = document.data()
                    let id = document.documentID
                    let name = data["name"] as? String ?? ""
                    let price = data["price"] as? Int ?? 0
                    let img_url = data["img_url"] as? String ?? ""
                    let brand = data["brand"] as? String ?? ""
                    let popular = data["popular"] as? Bool ?? false
                    let type = data["type"] as? String ?? ""
                    let quantity = data["quantity"] as? Int ?? 0
                    return Product(id: id, name: name, price: price, img_url: img_url, brand: brand, popular: popular, type: type,quantity: quantity)
                }
            }
        }
    }
    func deleteItem(id: String) async{
        guard let uId else{
            return
        }
        let favItem = db.collection("User")
            .document(uId)
            .collection("Fav")
        do{
            let favRef = favItem.document(id)
            try await favRef.delete()
        }
        catch{
            print("Error \(error)")
        }
    }
    func showAlert(title: String, message: String){
        titleAlert = title
        messageAlert = message
        showingAlert = true
    }
}
