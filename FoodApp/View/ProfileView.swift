//
//  ProfileView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 27/02/2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var authenVM: AuthencationViewModel = AuthencationViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                ZStack{
                    Circle()
                        .frame(width: 110)
                        .foregroundColor(Color("AccentColor"))
                    Image("userImg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .clipShape(.circle)
                }
                Text("\(authenVM.userName)")
                    .font(Font.custom("Gill Sans", size: 20))
                .padding(.bottom,70)
                ForEach(SidebarTabs.allCases, id: \.self) { item in
                    NavigationLink(destination: item.sideBarView) {
                        HStack{
                            item.icon
                                .padding(.trailing)
                            Text(item.rawValue)
                                .foregroundColor(.black)
                                .font(Font.custom("Gill Sans", size: 20))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                        .padding()
                    }
                }
                Button(
                    action: {
                        authenVM.signOut()
                    },
                    label: {
                        HStack{
                            Image("Logout")
                                .padding(.trailing)
                            Text("Log Out")
                                .foregroundColor(.black)
                                .font(Font.custom("Gill Sans", size: 20))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                        .padding()
                })
            }
            
        }
    }
}

#Preview {
    ProfileView()
}

enum SidebarTabs: String, Hashable, CaseIterable{
    case about = "About and Profile"
    case paymentMethod = "Manage Payment Methods"
    case addressManage = "Manage Addresses"
    case orderHistory = "Order History"
    case contactSupport = "Contact and Support"
    var icon: Image{
        switch self{
        case .about:
            return Image("about")
        case .paymentMethod:
            return Image("paymentMethod")
        case .addressManage:
            return Image("addressManage")
        case .orderHistory:
            return Image("orderHistory")
        case .contactSupport:
            return Image("contactSupport")
        }
    }
    @ViewBuilder var sideBarView: some View {
        switch self {
        case .about:
            AboutAndProfileView()
        case .paymentMethod:
            Text("Manage Payment Methods")
        case .addressManage:
           ManageAddressView()
        case .orderHistory:
            Text("Order History")
        case .contactSupport:
            Text("Contact and Support")
        }
    }
}
