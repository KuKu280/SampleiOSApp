//
//  SampleRecord.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/5/22.
//

import Foundation

struct SampleRecord {
    var ItemTitle: String
    var price: String
    var username: String
    var email: String
    var location: String
    var phoneModel: String
    var phoneVersion: String
    var warranty: String
    var description: String
    var detail: String
    var photoUrl: String
    
    init(ItemTitle:String,price:String,username:String,email:String,location:String,phoneModel: String,phoneVersion: String,warranty: String,description: String,detail: String, photoUrl: String) {
        self.ItemTitle = ItemTitle
        self.price = price
        self.username = username
        self.email = email
        self.location = location
        self.phoneModel = phoneModel
        self.phoneVersion = phoneVersion
        self.warranty = warranty
        self.description = description
        self.detail = detail
        self.photoUrl = photoUrl
    }
}
