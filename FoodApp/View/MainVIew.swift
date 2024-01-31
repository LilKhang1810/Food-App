//
//  MainVIew.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 19/01/2024.
//

import SwiftUI

struct MainVIew: View {
    @AppStorage("pageOnboard") var pageOnboard = 1
    @StateObject var mainVm = MainViewController()
    var body: some View {
        NavigationView{
            if mainVm.isSignIn,!mainVm.currentUserId.isEmpty{
                ContentView()
            }
            else{
                if pageOnboard > totalPage {
                    GetStartedView()
                }
                else{
                    OnBoardView()
                }
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