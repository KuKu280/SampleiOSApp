//
//  LoginViewController.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/4/22.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var phoneNoTextField: UITextField!
    @IBOutlet weak var phoneNumberBgView: UIView!
    
    @IBOutlet weak var passwordBgView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var checkBoxBtn: CheckBox!
    
    
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRX()
        bindData()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.backgroundColor = .green
    }
    
    fileprivate func setupRX() {
        loginBtn.rx.tap.do(onNext: { [self] in
            self.loginViewModel.phoneNoErrorMessage
                .bind(to: self.rx.phoneNoError)
                .disposed(by: self.disposeBag)
            self.loginViewModel.passwordErrorMessage
                .bind(to: self.rx.passwordError)
                .disposed(by: self.disposeBag)
        }).subscribe(onNext: { [self] in
            if loginViewModel.validation(credentials: Credentials(phoneNo: phoneNoTextField.stringValue, password: passwordTextField.stringValue)) {
                if checkBoxBtn.isChecked{
                    errorLabel.isHidden = true
                    let vc = baseViewVC
                    navigationController?.pushViewController(vc, animated: true)
                }else{
                    errorLabel.isHidden = false
                    errorLabel.text = "Please check this box"
                }
                
                
            }
        }).disposed(by: disposeBag)
    }
    
    func bindData(){
        loginViewModel.isPhoneNoTextFieldHightLighted.bind {
            if $0 {self.highlightTextField(self.phoneNoTextField)}
        }
        
        loginViewModel.isPasswordTextFieldHightLighted.bind {
            if $0 {self.highlightTextField(self.passwordTextField)}
        }
    }
            
    fileprivate func setupUI(){
        phoneNoTextField.leftImage(UIImage(named: "phone"), imageWidth: 10, padding: 10)
        passwordTextField.leftImage(UIImage(named: "password"), imageWidth: 10, padding: 10)
        loginBtn.layer.cornerRadius = 7
        textFieldSetup()
    }
    
    func textFieldSetup() {
        phoneNoTextField.delegate = self
        passwordTextField.delegate = self
        phoneNoTextField.text = ""
        passwordTextField.text = ""
    }
   
    func highlightTextField(_ textField: UITextField) {
        textField.resignFirstResponder()
        phoneNumberBgView.backgroundColor = .red
        passwordBgView.backgroundColor = .red
    }
    
    @IBAction func termsConditionPressed(_ sender: Any) {
        let vc = WebViewController()
        vc.linkUrl = "https://www.onekyat.com/"
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension LoginViewController: UITextFieldDelegate{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.becomeFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.isHidden = true
        phoneNumberBgView.backgroundColor = .gray
        passwordBgView.backgroundColor = .gray
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNoTextField {
            return phoneNoTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            return passwordTextField.becomeFirstResponder()
        }
        
        return true
    }
}

private extension Reactive where Base: LoginViewController {
    var phoneNoError: Binder<String> {
        return Binder(base) { vc, message in
            vc.errorLabel.isHidden = false
            vc.errorLabel.text = message
        }
    }

    var passwordError: Binder<String> {
        return Binder(base) { vc, message in
            vc.errorLabel.isHidden = false
            vc.errorLabel.text = message
        }
    }
}
