//
//  Credential.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/5/22.
//

import Foundation

struct Credentials {
    var phoneNo: String = ""
    var password: String = ""
    
    init(phoneNo: String, password:String) {
        self.phoneNo = phoneNo
        self.password = password
    }
}
