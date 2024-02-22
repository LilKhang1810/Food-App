//
//  UserAddress.swift
//  FoodApp
//
//  Created by Nguyễn Khang Hữu on 19/01/2024.
//

import Foundation
struct Address: Codable, Hashable{
    var id: String
    var addressType: String
    var address: String
    var zipCode: String
    var district: String
}
