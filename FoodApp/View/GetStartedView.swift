//
//  GetStartedView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 18/01/2024.
//

import SwiftUI

struct GetStartedView: View {
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Food-")
                        .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
                        .font(Font.custom("Bebas Neue", size: 28))
                    +
                    Text("E").foregroundColor(Color("AccentColor"))
                        .font(Font.custom("Bebas Neue", size: 28))
                }
                .padding(.trailing,280)
                HStack(spacing: 7){
                    Text("GET")
                        .font(Font.custom("Bebas Neue", size: 36))
                        .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
                    Text("STARTED")
                        .font(Font.custom("Bebas Neue", size: 36))
                        .foregroundColor(Color("AccentColor"))
                }
                .padding(.trailing,200)
                .padding(.top,40)
                Text("Get started and enjoy the awesome local food right at your home.")
                    .font(
                        Font.custom("Poppins", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
                    .frame(width: 335, alignment: .topLeading)
                Spacer()
                VStack{
                    NavigationLink(destination: LoginView()) {
                        Text("LOGIN")
                            .font(Font.custom("Bebas Neue", size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: 335, height: 40, alignment: .center)
                            .background(Color("AccentColor"))
                            .cornerRadius(20)
                    }
                    NavigationLink(destination: RegisterView()) {
                        Text("REGISTER")
                            .frame(width: 335, height: 40, alignment: .center)
                            .font(Font.custom("Bebas Neue", size: 18))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .inset(by: 1)
                                    .stroke(Color(red: 0.18, green: 0.86, blue: 0.74), lineWidth: 2)
                                
                            )
                    }
                }
                .padding(.bottom,20)
            }
        }
    }
}

struct GetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedView()
    }
}
