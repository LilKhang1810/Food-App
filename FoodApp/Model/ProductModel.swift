//
//  Product.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 17/01/2024.
//

import Foundation
import SwiftUI
struct Product : Hashable {
    var id: String
    var name: String
    var price: Int
    var img_url: String
    var brand: String
    var popular: Bool
    var type: String
}
struct Option: Hashable {
    var id: String
    var size: [String]
    var topping: [String]
}
