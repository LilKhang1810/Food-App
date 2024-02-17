//
//  CartView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 07/02/2024.
//

import SwiftUI
import SDWebImageSwiftUI
struct CartView: View {
    @StateObject var vm = CartViewController()
    @State var quantitySelected: Int = 1
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading){
                    Text("Basket")
                        .font(Font.custom("Bebas Neue", size: 35))
                        .padding(.trailing,250)
                        .padding(.top,30)
                    ForEach(vm.foods, id: \.self) { item in
                        NavigationLink(destination: DetailDishesView(product: Product(id: item.id, name: item.name, price: item.price, img_url: item.img_url, brand: item.brand, popular: item.popular, type: item.type), selectedType: item.type)) {
                            HStack {
                                AnimatedImage(url: URL(string: item.img_url))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 100)
                                VStack(alignment:.leading){
                                    HStack{
                                        Text(item.name)
                                            .font(.system(size: 15))
                                            .frame(width:200,height:20)
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                        Button(
                                            action: {},
                                            label: {
                                                Image("trashIcon")
                                            })
                                    }
                                    HStack{
                                        Text("\(item.price)đ")
                                            .font(Font.custom("Bebas Neue", size: 25))
                                        Spacer()
                                        HStack{
                                            Text("Qty: \(item.quantity)")
                                        }
                                        .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            VStack(alignment: .leading){
                Text("Total")
                    .font(Font.custom("Bebas Neue", size: 20))
                Text(String(vm.foods.reduce(0){$0 + (Int($1.price))})+" đ")
                    .font(Font.custom("Bebas Neue", size: 35))
                    .foregroundColor(.orange)
            }
            .padding(.trailing,220)
            .padding(.leading,30)
            Button(
                action: {},
                label: {
                    Text("Proceed to checkout")
                        .font(Font.custom("Bebas Neue", size: 20))
                        .foregroundColor(.white)
                        .frame(width: 350,height: 50)
                        .background(Color("AccentColor"))
                        .cornerRadius(20)
                })
            Spacer()
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
