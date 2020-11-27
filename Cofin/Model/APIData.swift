//
//  APIData.swift
//  Cofin
//
//  Created by Cong on 2020/11/8.
//

import Foundation

struct APIData: Codable {
    var name: String
    var city: String
    var tasty: Double
    var address: String
    var mrt: String?
    var url: String?
    var open_time: String?
    var latitude: String
    var longitude: String
}

struct APICities {
    var name: String
    var en_name: String
    var subhead: String
    var image: String
}

