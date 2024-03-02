//
//  ChangePasswordView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 02/03/2024.
//

import SwiftUI
struct ChangePasswordView: View {
    @StateObject var authenVM = AuthencationViewModel()
    @State var isShowing : Bool = false
    var body: some View {
        VStack(spacing:30){
            Text("Change Password")
                .font(Font.custom("Bebas Neue", size: 35))
                .padding(.top,30)
                .frame(maxWidth: .infinity,alignment: .leading)
            Spacer()
            VStack(alignment: .leading){
                Text("Current Password")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color("AccentColor"))
                TextField("Current Password", text: $authenVM.currentPassword)
                    .textFieldStyle(OvalTextFieldStyle())
            }
            VStack(alignment: .leading){
                Text("New Password")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color("AccentColor"))
                TextField("New Password", text: $authenVM.newPassword)
                    .textFieldStyle(OvalTextFieldStyle())
            }
            VStack(alignment: .leading){
                Text("Confirm Password")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color("AccentColor"))
                TextField("Confirm Password", text: $authenVM.confirmPassword)
                    .textFieldStyle(OvalTextFieldStyle())
            }
            Text(authenVM.errorMessage)
                .font(Font.custom("Bebas Neue", size: 15))
                .foregroundColor(.red)
            Button(
            action: {
                authenVM.changePassword()
            }, label: {
                Text("Change password")
                    .font(Font.custom("Bebas Neue", size: 25))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color("AccentColor"))
                    .cornerRadius(20)
            })
        }
        .padding()
    }
}

#Preview {
    ChangePasswordView()
}
