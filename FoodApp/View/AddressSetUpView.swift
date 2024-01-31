//
//  AddressSetUpView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 19/01/2024.
//

import SwiftUI

struct AddressSetUpView: View {
    @StateObject var addressVm = AddressViewModel()
    
    var body: some View {
        NavigationStack{
            Text("Address setup")
                .font(Font.custom("Bebas Neue", size: 36))
                .padding(.trailing,200)
            Spacer()
            VStack(alignment: .leading){
                Text("Full Name")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    .padding(.leading,20)
                TextField("Address", text: $addressVm.address).textFieldStyle(OvalTextFieldStyle()).disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .padding()
            VStack(alignment: .leading){
                Text("Zip Code")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    .padding(.leading,20)
                TextField("Email", text: $addressVm.zipCode).textFieldStyle(OvalTextFieldStyle()).disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .padding()
            VStack(alignment:.leading){
                Text("City")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    .padding(.leading,20)
                TextField("Password", text: $addressVm.city).textFieldStyle(OvalTextFieldStyle()).disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .padding()
            VStack{
                Button(action: {
                    addressVm.setUpAddress()
                },
                       label: {
                    Text("Add address")
                        .frame(width: 335,height: 40)
                        .font(Font.custom("Bebas Neue", size: 28))
                        .foregroundColor(.white)
                        .background(Color(red: 0.18, green: 0.86, blue: 0.74))
                        .cornerRadius(30)
                })
                Button(action: {
                    
                },
                       label: {
                    // Body
                    Text("Skip for now")
                        .font(
                            Font.custom("Poppins", size: 17)
                                .weight(.medium)
                        )
                        .foregroundColor(Color(red: 0.64, green: 0.64, blue: 0.64))
                })
            }
            .padding(.top,50)
            .padding(.bottom,50)
        }
    }
}
struct AddressSetUpView_Previews: PreviewProvider {
    static var previews: some View {
        AddressSetUpView()
    }
}
