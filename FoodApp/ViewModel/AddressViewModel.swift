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
    @Published var district = ""
    @Published var addressType = ""
    private let db = Firestore.firestore()
    private let uId = Auth.auth().currentUser?.uid
    @Published var addresses:[Address] = []
    @Published var newId = UUID().uuidString
    init(){
        fetchAddressData()
    
    }
    func fetchAddressData(){
        guard let uId else{
            return
        }
        db.collection("User")
            .document(uId)
            .collection("Address")
            .addSnapshotListener { snapshot, error in
                guard error == nil else{
                    return
                }
                if let snapshot = snapshot{
                    self.addresses = snapshot.documents.compactMap({ document in
                        let data = document.data()
                        let id = document.documentID
                        let address = data["address"] as? String ?? ""
                        let addressType = data["addressType"] as? String ?? ""
                        let zipCode = data["zipCode"] as? String ?? ""
                        let district = data["district"]as? String ?? ""
                        return Address(id: id, addressType: addressType, address: address, zipCode: zipCode, district: district)
                    })
                }
            }
    }
    func setUpAddress(){
        guard let uId else{
            return
        }
        let newAddress = Address(id: newId,
                                 addressType: addressType,
                                 address: address,
                                 zipCode: zipCode,
                                 district: district)
        db.collection("User")
            .document(uId)
            .collection("Address")
            .document(newId)
            .setData(newAddress.asDictionary())
    }
    func updateAddress(addressId: String) {
        guard let uId = uId else {
            return
        }
        
        let updateData: [String: Any] = [
            "addressType": addressType,
            "address": address,
            "zipCode": zipCode,
            "district": district
        ]
        
        db.collection("User")
            .document(uId)
            .collection("Address")
            .document(addressId)
            .updateData(updateData) { error in
                if let error = error {
                    print("Lỗi khi cập nhật địa chỉ: \(error.localizedDescription)")
                } else {
                    print("Đã cập nhật địa chỉ thành công!")
                }
            }
    }
    func deleteAddress(id:String){
        guard let uId else{
            return
        }
        db.collection("User")
            .document(uId)
            .collection("Address")
            .document(id)
            .delete()
    }
    func getAddressDocumentId(completion: @escaping (String?) -> Void) {
        guard let uId = uId else {
            completion(nil)
            return
        }
        
        db.collection("User")
            .document(uId)
            .collection("Address")
            .getDocuments { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    completion(nil)
                    return
                }
                
                // Giả sử bạn chỉ quan tâm đến một tài liệu, nếu có
                if let document = documents.first {
                    completion(document.documentID)
                
                } else {
                    completion(nil)
                }
            }
    }
    func AddressChoose(addressId: String){
        if let index = addresses.firstIndex(where: {$0.id == addressId}){
            addresses[index].isPrimary = true
        }
    }
}
