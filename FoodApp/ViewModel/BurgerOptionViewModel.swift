//
//  BurgerOptionViewModel.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 30/01/2024.
//

import SwiftUI
import Firebase
class BurgerOptionViewModel: ObservableObject{
    @Published var burgerOptions: [String: Any] = [:]
    var optionArray: [String]{
        return burgerOptions.map{ "\($0.value)" }
    }
    init(){
        fetchOption()
    }
    func fetchOption(){
        let ref = Database.database().reference().child("burgerOption")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if let value = snapshot.value as? [String: Any] {
                DispatchQueue.main.async {
                    self.burgerOptions = value
                }
                
            }
        }) { error in
            print(error.localizedDescription)
        }
    }
}

