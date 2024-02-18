//
//  BrandShowAllView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 22/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailDishesView: View {
    @State var product: Product
    @State var cart: Cart = Cart(id: "", name: "", img_url: "")
    @StateObject var productVM = ProductViewController()
    @State var showPizzaOptionScreen:Bool = false
    @State var showBurgerOptionScreen:Bool = false
    @State var selectedPizzaOption: String = "No option"
    @State var selectedBurgerOption: String = "No option"
    @State var quantity: Int = 1
    @State var optionPrice: Int = 0
    var subTotal: Int {
        return (product.price + optionPrice) * product.quantity
    }
    let selectedType: String
    var filterType:[Product] {
        productVM.products.filter{$0.type == selectedType}
    }

    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        AnimatedImage(url: URL(string: product.img_url))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        VStack(alignment: .leading){
                            Text(product.name)
                                .font(Font.custom("Bebas Neue", size: 26))
                                .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
                            HStack{
                                VStack(alignment:.leading){
                                    Text(product.brand)
                                        .font(
                                            Font.custom("Poppins", size: 16)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(Color(red: 0.97, green: 0.6, blue: 0.16))
                                }
                                Spacer()
                                VStack(alignment:.trailing){
                                    Image("Clock")
                                    Text("10 Mins")
                                        .font(
                                            Font.custom("Poppins", size: 16)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(Color(red: 0.97, green: 0.6, blue: 0.16))
                                }
                            }
                        }
                        
                        .padding(.horizontal,10)
                        if selectedType == "pizza" {
                            VStack{
                                Button(action: { showPizzaOptionScreen.toggle()
                                    print("\(showPizzaOptionScreen)") }) {
                                        Text("Selected option: \(selectedPizzaOption)")
                                            .frame(width: 320, height: 20)
                                            .foregroundColor(.black)
                                            .padding()
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color.black, lineWidth: 2)
                                            )
                                    }
                            }
                        }
                        if selectedType == "hamburger" {
                            VStack{
                                Button(action: { showBurgerOptionScreen.toggle()
                                    print("\(showBurgerOptionScreen)") }) {
                                        Text("Selected option: \(selectedBurgerOption)")
                                            .frame(width: 320, height: 20)
                                            .foregroundColor(.black)
                                            .padding()
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color.black, lineWidth: 2)
                                            )
                                    }
                            }
                        }
                        HStack{
                            VStack(alignment:.leading){
                                Text("Quantity")
                                    .font(Font.custom("Bebas Neue", size: 15))
                                    .foregroundColor(Color("AccentColor"))
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 157, height: 40)
                                    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                                
                                    .cornerRadius(20)
                                    .overlay{
                                        HStack{
                                            Text("\(product.quantity)")
                                            Spacer()
                                            Button(
                                                action: {
                                                    if product.quantity == 1{
                                                        product.quantity = 1
                                                    }
                                                    else{
                                                        product.quantity -= 1
                                                    }
                                                }) {
                                                    Image(systemName: "minus")
                                                }
                                                .padding(.trailing,10)
                                            
                                            Button(action: {product.quantity+=1}) {
                                                Image(systemName: "plus")
                                            }
                                        }
                                        .padding(.horizontal,20)
                                    }
                            }
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("Sub total")
                                    .font(Font.custom("Bebas Neue", size: 15))
                                Text("\(subTotal)đ")
                                    .font(Font.custom("Bebas Neue", size: 25))
                                    .foregroundColor(Color("AccentColor"))
                            }
                        }
                        .padding(.horizontal,20)
                        Button(
                            action: {
                                Task{
                                    await productVM.addToCart(item:product,optionPrice:optionPrice,quantity: product.quantity)
                                }
                            },
                            label: {
                                Rectangle()
                                    .foregroundColor(Color("AccentColor"))
                                    .frame(width: 320,height: 50)
                                    .cornerRadius(25)
                                    .overlay{
                                        Text("Add to basket")
                                            .font(Font.custom("Bebas Neue", size: 25))
                                            .foregroundColor(.white)
                                    }
                            })
                        .alert(isPresented: $productVM.showingAlert) {
                            Alert(title: Text(productVM.titleAlert),message: Text(productVM.messageAlert),dismissButton: .default(Text("OK")))
                        }
                    }
                }
                if showPizzaOptionScreen == true{
                    
                    optionPizzaScreen(showPizzaOptionScreen: $showPizzaOptionScreen, selectedPizzaOption: $selectedPizzaOption,optionPrice: $optionPrice) { option in
                        selectedPizzaOption = option
                        showPizzaOptionScreen = false
                    }
                    .offset(y:showPizzaOptionScreen ? 180 : UIScreen.main.bounds.height * (1))
                    .animation(.spring())
                }
                
                if showBurgerOptionScreen{
                    
                    optionBurgerScreen(showBurgerOptionScreen: $showBurgerOptionScreen, selectedBurgerOption: $selectedBurgerOption,optionPrice: $optionPrice) { option in
                        selectedBurgerOption = option
                        showBurgerOptionScreen = false
                    }
                    .offset(y:showBurgerOptionScreen ? 180 : UIScreen.main.bounds.height * (1))
                    .animation(.spring())
                }
            }
        }
    }
    
}

struct DetailDishesView_Previews: PreviewProvider {
    static var previews: some View {
        DetailDishesView(product: Product(id: "1PI3RayUQuHXOnxGVEcE", name: "EVM serving of 6 chicken McNuggets™", price: 79000, img_url: "https://mcdonalds.vn/uploads/2018/food/evm/EVM_03_6pcs_chicken_mcnuggets_0.png", brand: "Mc Donald", popular: true,type: "chicken fried"), selectedType: "pizza")
    }
}

struct optionPizzaScreen:View{
    @Binding var showPizzaOptionScreen: Bool
    @Binding var selectedPizzaOption: String
    @Binding var optionPrice: Int
    var optionSelected:(String) -> Void
    var body: some View{
        ZStack{
            Color.white
                .shadow(radius: 10)
            VStack{
                HStack {
                    Text("Option")
                        .foregroundColor(.black)
                        .padding(.leading, 20)
                        .font(.system(size: 25))
                    Spacer()
                    Button(action: {
                        showPizzaOptionScreen.toggle()
                    }) {
                        Image(systemName: "xmark")
                            .font(.body)
                            .foregroundColor(.black)
                            .padding()
                    }
                }
                Form{
                    Picker("", selection: $selectedPizzaOption) {
                        ForEach(pizzaOption.sorted(by:{$0.value < $1.value}), id: \.key) { (key,value) in
                            Text("\(key): \(value)đ")
                                .font(Font.custom("Bebas Neue", size: 25))
                        }
                    }
                    .pickerStyle(.inline)
                    .listRowSeparator(.hidden)
                }
                .scrollContentBackground(.hidden)
                .background(.white)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7)
        .onChange(of: selectedPizzaOption) { newValue in
            optionSelected(newValue)
            if let price = pizzaOption[newValue]{
                optionPrice = price
            }
        }
    }
}


struct optionBurgerScreen:View{
    @Binding var showBurgerOptionScreen: Bool
    @Binding var selectedBurgerOption: String
    @Binding var optionPrice: Int
    var optionSelected:(String) -> Void
    var body: some View{
        ZStack{
            Color.white
                .shadow(radius: 10)
            VStack{
                HStack {
                    Text("Option")
                        .font(Font.custom("Bebas Neue", size: 30))
                        .foregroundColor(.black)
                        .padding(.leading, 20)
                        .padding(.top,20)
                        .font(.system(size: 25))
                    Spacer()
                    Button(action: {
                        showBurgerOptionScreen.toggle()
                    }) {
                        Image(systemName: "xmark")
                            .font(.body)
                            .foregroundColor(.black)
                            .padding()
                    }
                }
                Form{
                    Picker("", selection: $selectedBurgerOption) {
                        ForEach(burgerOption.sorted(by: { $0.value < $1.value }), id: \.key) { (key, value) in
                            Group {
                                Text("\(key): \(value)đ")
                                    .font(Font.custom("Bebas Neue", size: 25))
                            }
                        }
                    }
                    .pickerStyle(.inline)
                    .listRowSeparator(.hidden)
                }
                .scrollContentBackground(.hidden)
                .background(.white)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7)
        .onChange(of: selectedBurgerOption) { newValue in
            optionSelected(newValue)
            if let price = burgerOption[newValue]{
                optionPrice = price
            }
        }
    }
}

let burgerOption = ["Add Vegetable": 5000,
                    "Add cheese": 10000,
                    "Add Sauce": 0,
                    "No Chili Sauce":0,
                    "No option":0,
]

let pizzaOption = ["No option":0,
                   "Add meat": 30000,
                   "Add cheese":20000,
                   "Upgrade Size M":30000,
                   "Upgrade Size L":50000]
