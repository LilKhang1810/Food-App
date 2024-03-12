//
//  FoodAppApp.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 17/01/2024.
//

import SwiftUI
import SwiftData
import FirebaseCore
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Connected")
        return true
    }
}
@main
struct FoodAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        @StateObject var authenVM : AuthencationViewModel = AuthencationViewModel()
        WindowGroup {
            MainVIew()
                .environmentObject(AuthencationViewModel())
        }
        .modelContainer(for:[Suggest.self])
    }
}
