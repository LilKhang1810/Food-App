//
//  CheckOutView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 20/02/2024.
//

import SwiftUI

struct CheckOutView: View {
    let totalCash: Int
    @EnvironmentObject var vm : CartViewController
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading){
                Text("Checkout")
                    .font(Font.custom("Bebas Neue", size: 35))
                    .padding(.top,30)
                    .padding(.bottom,200)
                    .padding(.horizontal,15)
                Text("Price")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .padding(.horizontal,15)
                Text("\(totalCash) đ")
                    .font(Font.custom("Bebas Neue", size: 35))
                    .foregroundColor(Color("AccentColor"))
                    .padding(.bottom,70)
                    .padding(.horizontal,15)
                Text("Deliver to")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .padding(.horizontal,15)
                HStack{
                    Text("Home")
                        .font(Font.custom("Gill Sans", size: 20))
                    Spacer()
                    NavigationLink(destination: ManageAddressView()) {
                        Text("Change")
                            .font(Font.custom("Gill Sans", size: 20))
                            .foregroundColor(.orange)
                    }
                }
                
                .padding(.horizontal,15)
                .padding(.bottom,70)
                Text("Payment method")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .padding(.horizontal,15)
                HStack{
                    Text("XXXX XXXX XXXX 2538")
                        .font(Font.custom("Gill Sans", size: 20))
                    Spacer()
                    NavigationLink(destination: Text("Change payment method")) {
                        Text("Change")
                            .font(Font.custom("Gill Sans", size: 20))
                            .foregroundColor(.orange)
                    }
                }
                .padding(.horizontal,15)
                Button(action: {
                
                }, label: {
                    NavigationLink(destination: OrderConfirmView()) {
                        Text("Confirm Order")
                            .font(Font.custom("Bebas Neue", size: 20))
                            .foregroundColor(.white)
                            .frame(width: 350,height: 50)
                            .background(Color("AccentColor"))
                            .cornerRadius(25)
                    }
                })
                .onAppear{
                    Task{
                        await vm.deleteCart()
                    }
                }
                .padding(.top,35)
                .frame(maxWidth: .infinity,alignment: .center)
            }
            .frame(maxWidth: .infinity,alignment:.leading)
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(totalCash: 100000)
            .environmentObject(CartViewController())
    }
}

struct OrderConfirmView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Color("successColor")
                
                    .ignoresSafeArea()
                VStack{
                    Text("order confirmed!")
                        .font(Font.custom("Bebas Neue", size: 40))
                        .foregroundColor(.white)
                    Image("successImg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                        .shadow(radius: 10,y: 10)
                    Text("Hang on Tight! We’ve received your order and we’ll bring it to you ASAP!")
                        .font(Font.custom("Gill Sans", size: 20))
                        .foregroundColor(.white)
                        .frame(width: 350)
                        .multilineTextAlignment(.center)
                        .padding(.top,45)
                    NavigationLink(destination: MapView()) {
                        Text("Track my Order")
                            .font(Font.custom("Bebas Neue", size: 20))
                            .foregroundColor(Color("AccentColor"))
                            .frame(width: 350,height: 50)
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 10,y:10)
                    }
                    .padding(.top,95)
                    .frame(maxWidth: .infinity,alignment: .center)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
