//
//  OnBoardView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 18/01/2024.
//

import SwiftUI

struct OnBoardView: View{
    @AppStorage("pageOnboard") var pageOnboard = 1
    var body: some View{
        ZStack{
            if pageOnboard == 1{
                SlideView(imageName: "onboarding1", title1: "AWESOME", title2: "LOCAL", title3: "FOOD", subTitle: "Discover delicious food from the amazing restaurants near you")
            }
            if pageOnboard == 2 {
                SlideView(imageName: "onboarding2", title1: "DELIVERED AT", title2: "YOUR", title3: "DOORSTEP", subTitle: "Fresh and delicious local food delivered from the restaurants to your doorstep")
            }
            if pageOnboard == 3{
                SlideView(imageName: "onboarding3", title1: "GRAB THE", title2: "BEST DEAL", title3: "AROUND", subTitle: "Grab the best deals and discounts around and save on your every order")
            }
        }
        .overlay(
            Button(
                action: {
                    withAnimation(.easeInOut) {
                        if pageOnboard < totalPage {
                            pageOnboard += 1
                        } else {
                            pageOnboard = 4
                        }
                    }
                    print("\(pageOnboard)")
                },
                label: {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 335, height: 40)
                        .background(Color(red: 0.18, green: 0.86, blue: 0.74))
                        .cornerRadius(20)
                        .overlay(
                            Text(pageOnboard == 3 ? "GET STARTED" : "NEXT")
                                .font(Font.custom("Bebas Neue", size: 18))
                                .foregroundColor(.white)
                                .frame(width: 335, height: 40, alignment: .center)
                        )
                })
            .offset(y:350)
        )
    }
    
}

struct SlideView: View {
    var imageName: String
    var title1: String
    var title2: String
    var title3: String
    var subTitle: String
    @AppStorage("pageOnboard") var pageOnboard = 1
    var body: some View {
        ZStack{
            Image(imageName)
                .resizable()
                .frame(maxHeight: .infinity)
                .ignoresSafeArea()
            VStack(alignment:.leading){
                HStack{
                    Text("Food-")
                        .foregroundColor(Color.white)
                        .font(Font.custom("Bebas Neue", size: 28))
                    +
                    Text("E").foregroundColor(Color("AccentColor"))
                        .font(Font.custom("Bebas Neue", size: 28))
                }
                .padding(.trailing,280)
                Spacer()
                Text(title1)
                    .font(Font.custom("Bebas Neue", size: 36))
                    .foregroundColor(.white)
                HStack{
                    Text(title2)
                        .font(Font.custom("Bebas Neue", size: 36))
                        .foregroundColor(Color("AccentColor"))
                    Text(title3)
                        .font(Font.custom("Bebas Neue", size: 36))
                        .foregroundColor(.white)
                }
                Text(subTitle)
                    .font(
                        Font.custom("Poppins", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(.white)
                    .frame(width: 335, alignment: .topLeading)
                    .padding(.top,10)
                    .padding(.bottom,30)
            }.padding(.bottom,35)
        }
    }
}

struct OnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardView()
    }
}

