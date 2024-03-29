//
//  CartViewController.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 11/02/2024.
//

import Foundation
import Firebase
import FirebaseAuth
class CartViewController: ObservableObject{
    @Published var foods:[Product] = []
    private let db = Firestore.firestore()
    private let uId = Auth.auth().currentUser?.uid
    @Published var showingAlert: Bool = false
    @Published var messageAlert = ""
    @Published var titleAlert = ""
    @Published var cartId = UUID().uuidString
    @Published var isDeleting: Bool = false
    init(){
        fetchFood()
    }
    func fetchFood(){
        guard let uId else{
            return
        }
        let cartdb = db.collection("User").document(uId).collection("Cart")
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
        let cartItem = db.collection("User")
            .document(uId)
            .collection("Cart")
        do{
            let cartRef = cartItem.document(id)

            try await cartRef.delete()
            
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
    func deleteCart() async {
        guard let uId = uId else {
            return
        }

        let cartRef = db.collection("User").document(uId).collection("Cart")

        // Set isDeleting flag to true while deleting
        isDeleting = true

        do {
            let snapshot = try await cartRef.getDocuments()
            for document in snapshot.documents {
                try await document.reference.delete()
            }
            self.foods = [] // Empty the local array as well
            isDeleting = false // Reset flag upon successful deletion

        } catch {
            isDeleting = false // Reset flag even on error
            print("Error deleting cart: \(error)")
            self.showAlert(title: "Error", message: "Failed to delete entire cart. Please try again.")
        }
    }
}
