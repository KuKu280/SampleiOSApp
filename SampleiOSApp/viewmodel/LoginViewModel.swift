//
//  LoginViewModel.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/5/22.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel{
    
    let phoneNoErrorMessage: PublishSubject<String> = PublishSubject()
    let passwordErrorMessage: PublishSubject<String> = PublishSubject()
    let ErrorMessage: PublishSubject<String> = PublishSubject()
    let isPhoneNoTextFieldHightLighted:Observe<Bool> = Observe(false)
    let isPasswordTextFieldHightLighted:Observe<Bool> = Observe(false)
    let error : PublishSubject<Error> = PublishSubject()
 
    
    func validation(credentials: Credentials) -> Bool {
        
        if credentials.phoneNo.isEmpty && credentials.password.isEmpty{
            phoneNoErrorMessage.onNext(ValidationError.emptyType.rawValue)
            passwordErrorMessage.onNext(ValidationError.emptyType.rawValue)
            isPhoneNoTextFieldHightLighted.value = true
            isPasswordTextFieldHightLighted.value = true
            return false
        }
        
        if credentials.phoneNo != isPhoneNo{
            phoneNoErrorMessage.onNext(PhoneNumberValidationError.invalidPhoneNumber.rawValue)
            isPhoneNoTextFieldHightLighted.value = true
            return false
        }
    
        
        if credentials.password.isEmpty{
            passwordErrorMessage.onNext(ValidationError.emptyPassword.rawValue)
            isPasswordTextFieldHightLighted.value = true
            return false
        }
        
       
        if credentials.password != isPassword{
            passwordErrorMessage.onNext(PasswordValidationError.invalidPassword.rawValue)
            isPasswordTextFieldHightLighted.value = true
            return false
        }
        
        if credentials.phoneNo.isEmpty{
            phoneNoErrorMessage.onNext(ValidationError.emptyPhonNo.rawValue)
            isPhoneNoTextFieldHightLighted.value = true
            return false
        }
        
        phoneNoErrorMessage.onNext("")
        passwordErrorMessage.onNext("")
        return true
    }
}
