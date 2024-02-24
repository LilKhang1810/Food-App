//
//  ManageAddressView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 22/02/2024.
//

import SwiftUI

struct ManageAddressView: View {
    @StateObject var addressVM = AddressViewModel()
    @AppStorage("selectedAddress") var selectedAddress: String = ""

    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    VStack(alignment: .leading){
                        Text("My address")
                            .font(Font.custom("Bebas Neue", size: 35))
                            .padding(.top,30)
                            .padding(.bottom,150)
                        ForEach(addressVM.addresses, id: \.self) { data in
                            VStack(alignment:.leading){
                                HStack{
                                    Text(data.addressType)
                                        .font(Font.custom("Bebas Neue", size: 15))
                                        .foregroundColor(.orange)
                                    
                                        Image(systemName: selectedAddress == data.id ? "checkmark" : "")
                                        
                                    
                                    Spacer()
                                    NavigationLink(destination: AddressUpdateView(userAddress: Address(id: data.id, addressType: data.addressType, address: data.address, zipCode: data.zipCode, district: data.district))) {
                                        Text("Change")
                                            .font(Font.custom("Bebas Neue", size: 15))
                                    }
                                }
                                Text(data.address + ", " + data.district)
                                    .font(Font.custom("Gill Sans", size: 20))
                                
                            }
                            .padding(.vertical,20)
                            .onTapGesture {
                                addressVM.AddressChoose(addressId: data.id)
                                selectedAddress = data.id
                                print("You choose \(data)")
                                
                            }
                        }
                        
                    }
                    .frame(maxWidth: .infinity,alignment:.leading)
                    .padding(.horizontal,20)
                    
                    NavigationLink(destination: AddressSetUpView()) {
                        Text("Add new address")
                            .font(Font.custom("Bebas Neue", size: 20))
                            .foregroundColor(.white)
                            .frame(width: 350,height: 50)
                            .background(Color("AccentColor"))
                            .cornerRadius(25)
                    }
                    .padding(.top,150)
                    
                }
            }
        }
    }
}

struct ManageAddressView_Previews: PreviewProvider {
    static var previews: some View {
        ManageAddressView()
    }
}
