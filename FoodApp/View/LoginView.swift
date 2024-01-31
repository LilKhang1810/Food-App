//
//  LoginView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 17/01/2024.
//

import SwiftUI
import FirebaseAuth
struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var authenVM : AuthencationViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            VStack{
                Text("Login")
                    .font(Font.custom("Bebas Neue", size: 36))
                    .padding(.trailing,280)
                Spacer()
                VStack(alignment: .leading){
                    Text("Email")
                        .font(Font.custom("Bebas Neue", size: 15))
                        .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                        .padding(.leading,20)
                    TextField("Email", text: $email).textFieldStyle(OvalTextFieldStyle())
                        .disableAutocorrection(true)
                                                .autocapitalization(.none)
                }
                .padding()
                VStack(alignment:.leading){
                    Text("Password")
                        .font(Font.custom("Bebas Neue", size: 15))
                        .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                        .padding(.leading,20)
                    SecureField("Password", text: $password).textFieldStyle(OvalTextFieldStyle())
                        .disableAutocorrection(true)
                                                .autocapitalization(.none)
                }
                .padding()
                NavigationLink(destination: ContentView()) {
                    Text("Forget password?")
                        .font(Font.custom("Poppins", size: 20)
                            .weight(.medium))
                        .foregroundColor(Color(red: 0.64, green: 0.64, blue: 0.64))
                        .padding(.leading,200)
                }
                .padding(.bottom,50)
                Button(
                    action: {
                        guard !email.isEmpty, !password.isEmpty else{
                            return
                        }
                        authenVM.signIn(email: email, password: password)
                    },
                    label: {
                        Text("LOGIN")
                            .frame(width: 335,height: 40)
                            .font(Font.custom("Bebas Neue", size: 28))
                            .foregroundColor(.white)
                            .background(Color(red: 0.18, green: 0.86, blue: 0.74))
                            .cornerRadius(30)
                    })
                HStack{
                    Text("Don't have an account?")
                        .font(
                            Font.custom("Poppins", size: 18)
                                .weight(.medium)
                        )
                        .foregroundColor(Color(red: 0.64, green: 0.64, blue: 0.64))
                    NavigationLink(destination: RegisterView()) {
                        Text(" Register")
                            .font(
                                Font.custom("Poppins", size: 18)
                                    .weight(.medium)
                            )
                            .foregroundColor(.orange)
                    }
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthencationViewModel())
    }
}
struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
            .cornerRadius(20)
    }
}
