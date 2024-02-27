//
//  ProfileView.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 27/02/2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var profileVM: AuthencationViewModel = AuthencationViewModel()
    var body: some View {
        Button("Log Out"){
            profileVM.signOut()
        }
    }
}

#Preview {
    ProfileView()
}
