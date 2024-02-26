//
//  AddressSetUpView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 19/01/2024.
//

import SwiftUI

struct AddressSetUpView: View {
    @StateObject var addressVm = AddressViewModel()
    let suggestedDistricts = ["District 1", "District 2", "District 3", "District 4", "District 5", "District 6", "District 7", "District 8", "District 9", "District 10", "District 11", "District 12", "Binh Tan District", "Binh Thanh District", "Go Vap District", "Phu Nhuan District", "Tan Binh District", "Tan Phu District", "Thu Duc District", "Nha Be District", "Hoc Mon District", "Cu Chi District", "Can Gio District","Binh Chanh District"]
    @State private var showSuggestions: Bool = true
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            Text("Address setup")
                .font(Font.custom("Bebas Neue", size: 36))
            
                .padding(.trailing,200)
            Spacer()
            VStack(alignment: .leading){
                Text("Address")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    .padding(.leading,20)
                TextField("Address", text: $addressVm.address).textFieldStyle(OvalTextFieldStyle()).disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .padding()
            VStack(alignment: .leading){
                Text("Type")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    .padding(.leading,20)
                TextField("Home", text: $addressVm.addressType).textFieldStyle(OvalTextFieldStyle()).disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .padding()
            VStack(alignment: .leading){
                Text("Zip Code")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    .padding(.leading,20)
                TextField("Zipcode", text: $addressVm.zipCode).textFieldStyle(OvalTextFieldStyle()).disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .padding()
            VStack(alignment: .leading) {
                Text("District")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    .padding(.leading, 20)
                
                TextField("District", text: $addressVm.district)
                    .textFieldStyle(OvalTextFieldStyle())
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                if !addressVm.district.isEmpty {
                    ScrollView(showsIndicators: false) {
                        ForEach(suggestedDistricts.filter { $0.hasPrefix(addressVm.district) }, id: \.self) { suggestion in
                            Button(action: {
                                self.addressVm.district = suggestion
                                self.showSuggestions = false
                            }) {
                                Text(suggestion)
                                    .padding()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: showSuggestions ? 100 : 0)
                    .animation(.easeInOut) // Add animation for smoother transition
                }
            }
            .padding()
            VStack{
                Button(action: {
                    addressVm.setUpAddress()
                    dismiss()
                },
                       label: {
                    Text("Add address")
                        .frame(width: 335,height: 40)
                        .font(Font.custom("Bebas Neue", size: 28))
                        .foregroundColor(.white)
                        .background(Color(red: 0.18, green: 0.86, blue: 0.74))
                        .cornerRadius(30)
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
struct AddressUpdateView: View {
    @StateObject var addressVm = AddressViewModel()
    let suggestedDistricts = ["District 1", "District 2", "District 3", "District 4", "District 5", "District 6", "District 7", "District 8", "District 9", "District 10", "District 11", "District 12", "Binh Tan District", "Binh Thanh District", "Go Vap District", "Phu Nhuan District", "Tan Binh District", "Tan Phu District", "Thu Duc District", "Nha Be District", "Hoc Mon District", "Cu Chi District", "Can Gio District","Binh Chanh District"]
    @State private var showSuggestions: Bool = true
    @Environment(\.dismiss) var dismiss
    @State var userAddress: Address
    var body: some View {
        NavigationStack{
            Text("Address setup")
                .font(Font.custom("Bebas Neue", size: 36))
            
                .padding(.trailing,200)
            Spacer()
            VStack(alignment: .leading){
                Text("Address")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    .padding(.leading,20)
                TextField(userAddress.address, text: $addressVm.address).textFieldStyle(OvalTextFieldStyle()).disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .padding()
            VStack(alignment: .leading){
                Text("Type")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    .padding(.leading,20)
                TextField(userAddress.addressType, text: $addressVm.addressType).textFieldStyle(OvalTextFieldStyle()).disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .padding()
            VStack(alignment: .leading){
                Text("Zip Code")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    .padding(.leading,20)
                TextField(userAddress.zipCode, text: $addressVm.zipCode).textFieldStyle(OvalTextFieldStyle()).disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .padding()
            VStack(alignment: .leading) {
                Text("District")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    .padding(.leading, 20)
                
                TextField(userAddress.district, text: $addressVm.district)
                    .textFieldStyle(OvalTextFieldStyle())
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                if !addressVm.district.isEmpty {
                    ScrollView(showsIndicators: false) {
                        ForEach(suggestedDistricts.filter { $0.hasPrefix(addressVm.district) }, id: \.self) { suggestion in
                            Button(action: {
                                self.addressVm.district = suggestion
                                self.showSuggestions = false
                            }) {
                                Text(suggestion)
                                    .padding()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: showSuggestions ? 100 : 0)
                    .animation(.easeInOut)                 }
            }
            .padding()
            VStack{
                Button(action: {
                    addressVm.getAddressDocumentId(forAddress: userAddress.address) { documentId in
                        if let documentId = documentId {
                            addressVm.updateAddress(addressId: documentId)
                            dismiss()
                        } else {
                            print("Không tìm thấy documentId")
                        }
                    }
                },
                       label: {
                    Text("Update address")
                        .frame(width: 335,height: 40)
                        .font(Font.custom("Bebas Neue", size: 28))
                        .foregroundColor(.white)
                        .background(Color(red: 0.18, green: 0.86, blue: 0.74))
                        .cornerRadius(30)
                    
                })
            }
            .padding(.top,50)
            .padding(.bottom,50)
            Button(
                action: {
                    addressVm.getAddressDocumentId(forAddress: userAddress.address) { documentId in
                        if let documentId = documentId{
                            addressVm.deleteAddress(id: documentId)
                            dismiss()
                            print("You deleted \(documentId)")
                        }else{
                            print("Not found document to delete")
                        }
                    }
                },
                label: {
                    Text("Delete Address")
                        .font(Font.custom("Bebas Neue", size: 15))
                        .foregroundColor(.red)
                })
            Text(userAddress.id)
        }
    }
}
