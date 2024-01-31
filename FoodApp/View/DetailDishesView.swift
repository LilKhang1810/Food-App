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
    @State private var selectedSize: String = "S"
    @State private var previousSize: String = "S"
    @StateObject var burgerOption = BurgerOptionViewModel()
    @StateObject var pizzaOption = PizzaOptionViewModel()
    @StateObject var productVM = ProductViewController()
    @State var showPizzaOptionScreen:Bool = false
    @State var showBurgerOptionScreen:Bool = false
    @State var selectedPizzaOption: String = ""
    @State var selectedBurgerOption: String = ""
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
                                    Text("\(product.price)đ")
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
                        Text("\(selectedType)")
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
                        if selectedType == "chicken fried"{
                            Text("not things")
                        }
                    }
                }
                if showPizzaOptionScreen == true{
                    
                    optionPizzaScreen(showPizzaOptionScreen: $showPizzaOptionScreen, selectedPizzaOption: $selectedPizzaOption) { option in
                        selectedPizzaOption = option
                        showPizzaOptionScreen = false
                    }
                    .offset(y:showPizzaOptionScreen ? 180 : UIScreen.main.bounds.height * (1))
                    .animation(.spring())
                }
                
                if showBurgerOptionScreen{
                    
                    optionBurgerScreen(showBurgerOptionScreen: $showBurgerOptionScreen, selectedBurgerOption: $selectedBurgerOption) { option in
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
        DetailDishesView(product: Product(id: "1PI3RayUQuHXOnxGVEcE", name: "EVM serving of 6 chicken McNuggets™", price: 79000, img_url: "https://mcdonalds.vn/uploads/2018/food/evm/EVM_03_6pcs_chicken_mcnuggets_0.png", brand: "Mc Donald", popular: true,type: "chicken fried"), selectedType: "hamburger")
    }
}

struct optionPizzaScreen:View{
    let pizzaOption = ["Add meat","Add cheese","Upgrade Size M","Upgrade Size L"]
    @Binding var showPizzaOptionScreen: Bool
    @Binding var selectedPizzaOption: String
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
                        ForEach(pizzaOption, id: \.self) { option in
                            Text("\(option)")
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
        }
    }
}


struct optionBurgerScreen:View{
    let burgerOption = ["Add Vegetable","Add cheese","Add Sauce","No Chili Sauce"]
    @Binding var showBurgerOptionScreen: Bool
    @Binding var selectedBurgerOption: String
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
                        ForEach(burgerOption, id: \.self) { option in
                            Text("\(option)")
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
        }
    }
}
