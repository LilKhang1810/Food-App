//
//  AuthencationViewModel.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 17/01/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
class AuthencationViewModel: ObservableObject{
    let auth = Auth.auth()
    @Published var signIn = false
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    private let uId = Auth.auth().currentUser?.uid
    var issignedIn: Bool{
        return auth.currentUser != nil
    }
    init(){
        fetchUserNameForCurrentUser()
    }
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){[weak self]result,error in
            guard result != nil, error == nil else{
                print("Sign Up Failed")
                return
            }
            DispatchQueue.main.async {
                self?.signIn = true
            }
        }
    }
    func signUp( email: String, password: String){
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard result == result, error == nil else {
                print("Lỗi khi tạo tài khoản: \(error?.localizedDescription ?? "")")
                return
            }
            self?.savetoFirestore(email: result?.user.email ?? "")
            DispatchQueue.main.async {
                self?.signIn = true
            }
        }
    }
    func signOut(){
        try? auth.signOut()
        self.signIn = false
    }
    func savetoFirestore(email: String){
        let collection = Firestore.firestore().collection("user")
        let document = collection.document(email)
        document.setData([
            "id": document.documentID,
            "email": email
        ])
        {
            error in
            if let error = error {
                print("Lỗi khi lưu dữ liệu vào Firestore: \(error.localizedDescription)")
            }
            else{
                print("Dữ liệu đã được lưu vào Firestore thành công.")
            }
        }
    }
    func fetchUserNameForCurrentUser() {
        guard let currentUser = Auth.auth().currentUser else {
            print("Không có người dùng đang đăng nhập.")
            return
        }
        
        let userID = currentUser.uid
        let db = Firestore.firestore()
        
        // Thực hiện truy vấn để lấy thông tin người dùng từ Firestore
        let userRef = db.collection("User").document(userID)
        userRef.addSnapshotListener { (document, error) in
            if let document = document, document.exists {
                // Lấy thông tin người dùng từ tài liệu
                if let userData = document.data(),
                   let userName = userData["name"] as? String,
                   let userEmail = userData["email"] as? String
                {
                    // Cập nhật tên của người dùng
                    self.userName = userName
                    self.userEmail = userEmail
                } else {
                    print("Không tìm thấy thông tin về tên của người dùng.")
                }
            } else {
                print("Tài liệu người dùng không tồn tại trong Firestore.")
            }
        }
    }
}
