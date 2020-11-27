//
//  UserData.swift
//  Cofin
//
//  Created by Cong on 2020/11/17.
//

import Foundation

struct UserCafeDatas: Codable{
    
    var userId: String
    var documentId: String
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
