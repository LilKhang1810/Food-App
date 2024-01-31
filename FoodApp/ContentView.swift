//
//  ContentView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 17/01/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var autenVM = AuthencationViewModel()
    @StateObject var productVM = ProductViewController()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Sign Out") {
                autenVM.signOut()
            }
            Button("Print ProductList"){
                
                print(productVM.products)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
