//
//  BrandShowAllView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 23/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI
struct BrandShowAllView: View {
    @StateObject var productVM = ProductViewController()
    let selectedBrand: String
    var filterBrand:[Product] {
        productVM.products.filter{$0.brand == selectedBrand}
    }
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack{
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2),spacing: 20){
                    ForEach(filterBrand,id:\.self) { item in
                        NavigationLink(destination: ContentView()) {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 158, height: 230)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.15), radius: 15, x: 0, y: 0)
                                    .padding()
                                VStack(alignment:.center){
                                    AnimatedImage(url: URL(string: item.img_url))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    Spacer()
                                    Text(item.name)
                                        .font(
                                            Font.custom("Poppins", size: 15)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(.black)
                                        .padding(.horizontal,10)
                                        .frame(maxHeight:40)
                                    HStack{
                                        Text("\(item.price)")
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
                }
            }
            .padding(.top,15)
        }
    }
}

struct BrandShowAllView_Previews: PreviewProvider {
    static var previews: some View {
        BrandShowAllView(selectedBrand: "Dominos")
    }
}
