//
//  RegisterView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 17/01/2024.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var registerVM = RegisterViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            Text("Register")
                .font(Font.custom("Bebas Neue", size: 36))
                .padding(.trailing,280)
            Spacer()
            VStack(alignment: .leading){
                Text("Full Name")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    .padding(.leading,20)
                TextField("Full Name", text: $registerVM.name).textFieldStyle(OvalTextFieldStyle())
                    .disableAutocorrection(true)
                                            .autocapitalization(.none)
            }
            .padding()
            VStack(alignment: .leading){
                Text("Email")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    .padding(.leading,20)
                TextField("Email", text: $registerVM.email).textFieldStyle(OvalTextFieldStyle())
                    .disableAutocorrection(true)
                                            .autocapitalization(.none)
            }
            .padding()
            VStack(alignment:.leading){
                Text("Password")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    .padding(.leading,20)
                SecureField("Password", text: $registerVM.password).textFieldStyle(OvalTextFieldStyle()).disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .padding()
            Button(
                action: {
                    registerVM.register()
                },
                label: {
                    Text("REGISTER")
                        .frame(width: 335,height: 40)
                        .font(Font.custom("Bebas Neue", size: 28))
                        .foregroundColor(.white)
                        .background(Color(red: 0.18, green: 0.86, blue: 0.74))
                        .cornerRadius(30)
                })
            HStack{
                Text("Already have an account?")
                    .font(
                        Font.custom("Poppins", size: 18)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.64, green: 0.64, blue: 0.64))
                NavigationLink(destination: LoginView()) {
                    Text(" Login")
                        .font(
                            Font.custom("Poppins", size: 18)
                                .weight(.medium)
                        )
                        .foregroundColor(.orange)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .padding(.trailing,330)
                        .padding(.vertical,50)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
