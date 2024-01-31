//
//  AddressViewModel.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 19/01/2024.
//

import Foundation
import FirebaseAuth
import Firebase
class AddressViewModel: ObservableObject{
    @Published var address = ""
    @Published var zipCode = ""
    @Published var city = ""
    private let db = Firestore.firestore()
    private let uId = Auth.auth().currentUser?.uid
    func setUpAddress(){
        guard let uId else{
            return
        }
        
        let newId = UUID().uuidString
        let newAddress = Address(id: newId,
                                 address: address,
                                 zipCode: zipCode,
                                 city: city)
        db.collection("User")
            .document(uId)
            .collection("Address")
            .document(newId)
            .setData(newAddress.asDictionary())
    }
}
