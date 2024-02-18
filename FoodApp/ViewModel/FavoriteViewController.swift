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
    init(){
        
    }
    func fetchFavDB(){
        guard let uId else{
            return
        }
        
    }
}
