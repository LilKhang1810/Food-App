//
//  ContentView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 17/01/2024.
//

import SwiftUI
import Firebase
class UserViewModel: ObservableObject {
    @Published var displayName: String = "Không có tên"
    
    init() {
        // Kiểm tra xem người dùng đã đăng nhập hay chưa
        if let currentUser = Auth.auth().currentUser {
            // Lấy tên hiển thị của người dùng nếu có
            if let displayName = currentUser.displayName {
                self.displayName = displayName
            }
        }
    }
}
struct ContentView: View {
    @EnvironmentObject var autenVM:AuthencationViewModel
    @StateObject var productVM = ProductViewController()
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        VStack {
            Text("Xin chào, \(autenVM.userName)!")
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Sign Out") {
                autenVM.signOut()
            }
            Button("Print ProductList"){
                
                print(productVM.products)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthencationViewModel())
    }
}
