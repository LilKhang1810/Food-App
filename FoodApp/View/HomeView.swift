//
//  HomeView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 20/01/2024.
//

import SwiftUI

import SDWebImageSwiftUI
struct HomeView: View {
    @StateObject var productVM = ProductViewController()
    @StateObject var brandVM = BrandViewModel()
    
    var popularDishes: [Product] {
        productVM.products.filter{$0.popular == true}
    }
    var body: some View {
        NavigationStack{
            ScrollView{
                HStack{
                    HStack{
                        Text("Hello,")
                        Text("Khang")
                            .foregroundColor(.accentColor) + Text("!")
                    }
                    .font(
                        Font.custom("Poppins", size: 24)
                            .weight(.medium)
                    )
                    Spacer()
                    HStack{
                        Text("HOME")
                            .font(Font.custom("Bebas Neue", size: 18))
                            .foregroundColor(Color(red: 0.97, green: 0.6, blue: 0.16))
                        Image("Location")
                    }
                }
                .padding(.horizontal,15)
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 355, height: 180)
                        .background(Color(red: 0.4, green: 0.9, blue: 0.81))
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 4)
                    VStack{
                        Text("Get")
                            .font(Font.custom("Bebas Neue", size: 28))
                            .foregroundColor(.white)
                        + Text(" 50% ")
                            .font(Font.custom("Bebas Neue", size: 33))
                        + Text("As a joining bonus")
                            .font(Font.custom("Bebas Neue", size: 28))
                            .foregroundColor(.white)
                    }
                    .offset(x:-20,y:-40)
                    VStack(alignment:.leading){
                        Text("Use code on checkout")
                            .font(Font.custom("Bebas Neue", size: 15))
                            .foregroundColor(.white)
                        Text("New50")
                            .font(Font.custom("Bebas Neue", size: 33))
                    }
                    .offset(x:-90,y:40)
                    Image("likeHand")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .offset(x:50,y:15)
                }
                // Label
                VStack(){
                    Text("Recommended for you")
                        .font(Font.custom("Bebas Neue", size: 20))
                        .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
                }
                .frame(maxWidth: .infinity,maxHeight: .none, alignment: .leading)
                .padding(.horizontal,25)
                
                ScrollView(.horizontal,showsIndicators: false){
                    HStack(spacing:30){
                        ForEach(productVM.products,id:\.self){item in
                            NavigationLink(destination: DetailDishesView(product: Product(id: item.id, name: item.name, price: item.price, img_url: item.img_url, brand: item.brand, popular: item.popular, type: item.type), selectedType: item.type)) {
                                ProductFrameView(img_url: item.img_url, name: item.name, price: item.price)
                            }
                        }
                    }
                    .padding(30)
                }
                VStack(){
                    Text("Restaurant")
                        .font(Font.custom("Bebas Neue", size: 20))
                        .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
                }
                .frame(maxWidth: .infinity,maxHeight: .none, alignment: .leading)
                .padding(.horizontal,30)
                ScrollView(.horizontal,showsIndicators: false){
                    HStack(spacing:30){
                        ForEach(brandVM.brands,id: \.self) { item in
                            NavigationLink(destination: BrandShowAllView( selectedBrand: item.name)) {
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 80, height: 80)
                                        .background(.white)
                                        .cornerRadius(20)
                                        .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 2)
                                    AnimatedImage(url: URL(string: item.img_url))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                            }
                        }
                    }
                    .padding(.horizontal,30)
                    .padding(.vertical,20)
                }
                VStack(){
                    Text("Popular in your area")
                        .font(Font.custom("Bebas Neue", size: 20))
                        .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
                }
                .frame(maxWidth: .infinity,maxHeight: .none, alignment: .leading)
                .padding(.horizontal,30)
                .padding(.vertical,15)
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 2),spacing: 20){
                            ForEach(popularDishes,id:\.self) { item in
                                NavigationLink(destination: ContentView()) {
                                    ProductFrameView(img_url: item.img_url, name: item.name, price: item.price)
                                }
                            }
                        }
                    }
                    .frame(height: 500)
                    .padding(.vertical,25)
                }
                
                VStack(spacing:30){
                    NavigationLink(destination: Text("Chicken Fried")) {
                        FrameTypeFood(title: "Chicken Fried", img: "chicken fried")
                    }
                    .shadow(color: Color("AccentColor").opacity(0.7), radius: 10, x: 0, y:10 )
                    NavigationLink(destination: Text("Pizza")) {
                        FrameTypeFood(title: "Pizza", img: "pizza")
                    }
                    .shadow(color: Color("AccentColor").opacity(0.7), radius: 10, x: 0, y:10 )
                    NavigationLink(destination: Text("Hamburger")) {
                        FrameTypeFood(title: "Hamburger", img: "hamburger")
                    }
                    .shadow(color: Color("AccentColor").opacity(0.7), radius: 10, x: 0, y:10 )
                }
                .padding(.top,40)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        
    }
}

struct FrameTypeFood: View {
    let title:String
    let img: String
    var body: some View {
        ZStack{
            HStack{
                Text(title)
                    .font(Font.custom("Bebas Neue", size: 18))
                    .foregroundColor(.black)
                    .padding(.leading,30)
                Spacer()
                Image(img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height:80)
                    .cornerRadius(10)
            }
            .frame(width: 355, height: 80)
            .background(Color("AccentColor"))
            .cornerRadius(10)
        }
    }
}

struct ProductFrameView: View {
    let img_url: String
    let name: String
    let price: Int
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 158, height: 230)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.15), radius: 15, x: 0, y: 0)
            VStack(alignment:.center){
                AnimatedImage(url: URL(string: img_url))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                Text(name)
                    .font(
                        Font.custom("Poppins", size: 15)
                            .weight(.medium)
                    )
                    .foregroundColor(.black)
                    .padding(.horizontal,10)
                    .frame(maxHeight:40)
                HStack{
                    Text("\(price) đ")
                        .font(Font.custom("Bebas Neue", size: 18))
                        .foregroundColor(Color(red: 0.18, green: 0.86, blue: 0.74))
                    Spacer()
                    Image("Basket")
                        .background(Color("AccentColor"))
                        .cornerRadius(5)
                }
                .padding(.horizontal,10)
                Spacer()
            }
            .frame(width: 158, height: 230)
        }
    }
}
