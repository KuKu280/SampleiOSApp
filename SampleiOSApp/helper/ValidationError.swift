//
//  ValidationError.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/5/22.
//

import Foundation

enum ValidationError: String, Error{
    case emptyPassword = "Pelease fill password"
    case emptyType = "Please fill this all fields!!"
    case emptyPhonNo = "Please fill the PhoneNumber"
}

enum PhoneNumberValidationError: String, Error {
    case invalidPhoneNumber = "Your phoneNumber is invalid."
}

enum PasswordValidationError: String, Error {
    case invalidPassword = "Your password is invalid"
    case emptyPassword = "Password is empty please fill."
    case shortPassword = "Password must have at least 8 characters."
    case longPassword = "Password cannot be over 15 characters."
    case passwordWithSpace = "Password cannot contain space."
    case passwordWithNoAlphabetOrDigit = "Password must contain at least one alphabet and one digit."
}
