import SwiftUI
import SwiftData
struct SearchView: View {
    
    @State var txt: String = ""
    @ObservedObject var vm = ProductViewController()
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Query(sort:\Suggest.name) var suggestes:[Suggest]
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Text("Search")
                    .font(Font.custom("Bebas Neue", size: 15))
                    .foregroundColor(Color("AccentColor"))
                    .padding(.horizontal,25)
                ZStack{
                    TextField("Search", text: $txt,onCommit: {
                        if !suggestes.contains(where: { $0.name == txt }) {
                            let suggest = Suggest(name: txt)
                            context.insert(suggest)
                        }
                    })
                    .font(Font.custom("Bebas Neue", size: 18))
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(.gray.opacity(0.3))
                    .cornerRadius(25)
                    
                    Button(
                        action: {
                            if !txt.isEmpty{
                                txt.removeLast()
                            }
                        },
                        label: {
                            Image("delBtn")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                        }
                    )
                    .offset(x:150)
                }
            }
            .padding(.horizontal,15)
            .padding(.bottom,15)
            ScrollView{
                VStack{
                    if self.txt.isEmpty{
                        ForEach(suggestes){suggest in
                            HStack{
                                Text(suggest.name)
                                Spacer()
                                Button(
                                    action: {
                                        context.delete(suggest)
                                    },
                                    label: {
                                        Image(systemName: "xmark")
                                    })
                            }
                            .padding()
                            .onTapGesture {
                                txt = suggest.name
                            }
                        }
                        
                    }
                    else{
                        if vm.products.filter({$0.name.lowercased().contains(self.txt.lowercased())}).count == 0{
                            Text("No Results Found").foregroundColor(Color.black.opacity(0.5)).padding()
                        }
                        else{
                            LazyVGrid(columns: Array(repeating: GridItem(), count: 2),spacing: 20){
                                ForEach(vm.products.filter({$0.name.lowercased().contains(self.txt.lowercased())}), id: \.self) { product in
                                    NavigationLink(destination: DetailDishesView(product: Product(id: product.id, name: product.name, price: product.price, img_url: product.img_url, brand: product.brand, popular: product.popular, type: product.type), selectedType: product.type)) {
                                        ProductFrameView(img_url: product.img_url, name: product.name, price: product.price, product: Product(id: product.id, name: product.name, price: product.price, img_url: product.img_url, brand: product.brand, popular: product.popular, type: product.type))
                                    }
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
