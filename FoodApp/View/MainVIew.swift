//
//  MainVIew.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 19/01/2024.
//

import SwiftUI

struct MainVIew: View {
    @AppStorage("pageOnboard") var pageOnboard = 1
    var body: some View {
        NavigationStack{
            if pageOnboard > totalPage {
                GetStartedView()
            }
            else{
                OnBoardView()
            }
        }
    }
}

struct MainVIew_Previews: PreviewProvider {
    static var previews: some View {
        MainVIew()
    }
}
var totalPage = 3
