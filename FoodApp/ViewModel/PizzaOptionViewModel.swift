//
//  PizzaOptionViewModel.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 30/01/2024.
//

import SwiftUI
import Firebase
class PizzaOptionViewModel: ObservableObject {
    @Published var pizzaOptions: [String: Any] = [:]

    // Thêm computed property
    var optionsArray: [String] {
        return pizzaOptions.map { "\($0.value)" }
    }

    init() {
        fetchOption()
    }

    func fetchOption() {
        let ref = Database.database().reference().child("pizzaOption")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if let value = snapshot.value as? [String: Any] {
                DispatchQueue.main.async {
                    self.pizzaOptions = value
                }
            }
        }) { error in
            print(error.localizedDescription)
        }
    }
}

