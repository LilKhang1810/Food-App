//
//  TabView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 02/02/2024.
//

import SwiftUI

struct TabsView: View {
    @State var selectedTab: Int = 1
    @State var isSelected: Bool = false
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(selectedTab == 1 ? "homeSelected" : "home")
                        
                }
                .tag(1)
            SearchView()
                .tabItem {
                    Image(selectedTab == 2 ? "searchSelected" : "search")
                }
                .tag(2)
            Text("CartView")
                .tabItem {
                    Image(selectedTab == 3 ?"cartSelected":"cart")
                }
                .tag(3)
            Text("FavoriteView")
                .tabItem {
                    Image(selectedTab == 4 ? "favoriteSelected": "favorite")
                }
                .tag(4)
            Text("ProfileView")
                .tabItem {
                    Image(selectedTab == 5 ?"profileSelected": "profile")
                }
                .tag(5)
        }
        .frame(height: 870,alignment: .center)
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
            .environmentObject(AuthencationViewModel())
    }
}
