//
//  CartModel.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 07/02/2024.
//

import Foundation
struct Cart: Codable,Hashable{
    var id: String
    var name: String
    var subTotal: Int = 0
    var img_url: String
    var quantity: Int = 0
}
