//
//  BrandViewModel.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 22/01/2024.
//

import Foundation
import SwiftUI
import Firebase

class BrandViewModel: ObservableObject{
    @Published var brands:[Brand] = []
    private let db = Firestore.firestore()
    init(){
        fetchBrand()
    }
    func fetchBrand(){
        let ref = db.collection("Brand")
        ref.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    let id = document.documentID
                    let name = data["name"] as? String ?? ""
                    let img_url = data["img_url"] as? String ?? ""
                    let brand = Brand(id: id, name: name, img_url: img_url)
                    self.brands.append(brand)
                }
            }
        }
    }
}
