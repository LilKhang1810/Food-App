//
//  AboutAndProfileView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 29/02/2024.
//

import SwiftUI

struct AboutAndProfileView: View {
    @StateObject var profileVM: AuthencationViewModel = AuthencationViewModel()
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Text("Account and Profile")
                    .font(Font.custom("Bebas Neue", size: 35))
                    .padding(.trailing,100)
                    .padding(.top,30)
                Button(action: {
                    
                }, label: {
                    HStack{
                        Image("trash")
                            .padding(.trailing,30)
                        Text("Delete Account")
                            .foregroundColor(Color("fail"))
                    }
                })
                Spacer()
                Text("Username")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    .padding(.leading,20)
                TextField("Username", text: $profileVM.userName)
                    .textFieldStyle(OvalTextFieldStyle())
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                Text("email")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    .padding(.leading,20)
                TextField("Email", text: $profileVM.userEmail)
                    .textFieldStyle(OvalTextFieldStyle())
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                NavigationLink(destination: Text("Change Password")) {
                    HStack{
                        Image("lockIcon")
                            .padding(.trailing)
                        Text("Change Password")
                            .font(Font.custom("Gill Sans", size: 15))
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }
                    .padding(.vertical,40)
                }
                Button(action: {
                    
                }, label: {
                    Text("Update")
                        .font(Font.custom("Bebas Neue", size: 20))
                        .foregroundColor(.white)
                        .frame(width: 350,height: 40)
                        .background(Color("AccentColor"))
                        .cornerRadius(25)
                })
            }
            .padding()
        }
    }
}

#Preview {
    AboutAndProfileView()
}
