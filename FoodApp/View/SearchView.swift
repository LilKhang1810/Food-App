//
//  SearchView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 06/02/2024.
//

import SwiftUI

struct SearchView: View {
    @State var txt: String = ""
    @ObservedObject var vm = ProductViewController()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading){
                    Text("Search")
                        .font(Font.custom("Bebas Neue", size: 15))
                        .foregroundColor(Color("AccentColor"))
                        .padding(.horizontal,25)
                    TextField("Search", text: $txt)
                        .font(Font.custom("Bebas Neue", size: 18))
                        .padding(.horizontal)
                        .frame(height: 50)
                        .background(.gray.opacity(0.3))
                        .cornerRadius(25)
                }
                .padding(.horizontal,15)
                .padding(.bottom,15)
                if !self.txt.isEmpty {
                    if vm.products.filter({$0.name.lowercased().contains(self.txt.lowercased())}).count == 0{
                        Text("No Results Found").foregroundColor(Color.black.opacity(0.5)).padding()
                    }
                    else{
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 2),spacing: 20){
                            ForEach(vm.products.filter({$0.name.lowercased().contains(self.txt.lowercased())}), id: \.self) { product in
                                NavigationLink(destination: DetailDishesView(product: Product(id: product.id, name: product.name, price: product.price, img_url: product.img_url, brand: product.brand, popular: product.popular, type: product.type), selectedType: product.type)) {
                                    ProductFrameView(img_url: product.img_url, name: product.name, price: product.price)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
