//
//  FavoriteView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 19/02/2024.
//

import SwiftUI
import SDWebImageSwiftUI
struct FavoriteView: View {
    @StateObject var favVm: FavoriteViewController = FavoriteViewController()
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Text("Liked")
                        .font(Font.custom("Bebas Neue", size: 35))
                        .padding(.trailing,250)
                        .padding(.top,30)
                    
                    ForEach(favVm.foods, id: \.self) { item in
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
                                            action: {
                                                favVm.showingAlert = true
                                            },
                                            label: {
                                                Image("trashIcon")
                                            })
                                        .alert(isPresented: $favVm.showingAlert) {
                                            Alert(title: Text("Are you sure?"),message: Text("You can like it again in home"), primaryButton: .default(Text("OK")){
                                                Task{
                                                    await favVm.deleteItem(id: item.id)
                                                }
                                            }, secondaryButton: .destructive(Text("Cancel")))
                                        }
                                    }
                                    HStack{
                                        Text("\(item.price*item.quantity)đ")
                                            .font(Font.custom("Bebas Neue", size: 25))
                                        Spacer()
                                        HStack{
                                            Text("Qty: \(item.quantity)")
                                        }
                                        .foregroundColor(.black)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
