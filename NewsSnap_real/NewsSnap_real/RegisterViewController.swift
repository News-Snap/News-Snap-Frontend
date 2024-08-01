//
//  RegisterViewController.swift
//  NewsSnap_real
//
//  Created by 문정현 on 7/17/24.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var NameTextField: UITextField!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var BirthdayTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var PasswordConfirmTextField: UITextField!
    
    @IBAction func SigninButton(_ sender: Any) {
    }
    
    @IBOutlet weak var SigninButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNameTextField()
        configureEmailTextField()
        configureBirthdayTextField()
        configurePasswordTextField()
        configurePasswordConfirmTextField()
        configureSigninButton()
        
        
        
        
        
    }
    
    // NameTextField - 디테일 설정하기
    private func configureNameTextField() {
        // NameTextField의 기본 테두리 제거
        NameTextField.borderStyle = .none
        
        // 새로운 하단 테두리 레이어 추가
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: NameTextField.frame.size.height - 1, width: NameTextField.frame.size.width, height: 1)
        
        // Assets에 저장된 MainColor로 하단 테두리 색상 설정
        if let mainColor = UIColor(named: "MainColor") {
            bottomBorder.backgroundColor = mainColor.cgColor
        } else {
            bottomBorder.backgroundColor = UIColor.black.cgColor // MainColor가 없을 경우 기본 색상 설정
        }
        
        NameTextField.layer.addSublayer(bottomBorder)
        
    
    }
    
    // EmailTextField - 디테일 설정하기
    
    // configureLoginTextfield() {}
    //
    //
    private func configureEmailTextField() {
        // EmailTextField의 기본 테두리 제거
        EmailTextField.borderStyle = .none
        
        // 새로운 하단 테두리 레이어 추가
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: EmailTextField.frame.size.height - 1, width: EmailTextField.frame.size.width, height: 1)
        
        // Assets에 저장된 MainColor로 하단 테두리 색상 설정
        if let mainColor = UIColor(named: "MainColor") {
            bottomBorder.backgroundColor = mainColor.cgColor
        } else {
            bottomBorder.backgroundColor = UIColor.black.cgColor // MainColor가 없을 경우 기본 색상 설정
        }
        
        EmailTextField.layer.addSublayer(bottomBorder)
    }
    
    
    // BirthdayTextField - 디테일 설정하기
    private func configureBirthdayTextField() {
        // BirthdayTextField의 기본 테두리 제거
        BirthdayTextField.borderStyle = .none
        
        // 새로운 하단 테두리 레이어 추가
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: BirthdayTextField.frame.size.height - 1, width: BirthdayTextField.frame.size.width, height: 1)
        
        // Assets에 저장된 MainColor로 하단 테두리 색상 설정
        if let mainColor = UIColor(named: "MainColor") {
            bottomBorder.backgroundColor = mainColor.cgColor
        } else {
            bottomBorder.backgroundColor = UIColor.black.cgColor // MainColor가 없을 경우 기본 색상 설정
        }
        
        BirthdayTextField.layer.addSublayer(bottomBorder)
    }
    
    
    // PasswordTextField - 디테일 설정하기
    private func configurePasswordTextField() {
        // PasswordTextField의 기본 테두리 제거
        PasswordTextField.borderStyle = .none
        
        // 새로운 하단 테두리 레이어 추가
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: PasswordTextField.frame.size.height - 1, width: PasswordTextField.frame.size.width, height: 1)
        
        // Assets에 저장된 MainColor로 하단 테두리 색상 설정
        if let mainColor = UIColor(named: "MainColor1") {
            bottomBorder.backgroundColor = mainColor.cgColor
        } else {
            bottomBorder.backgroundColor = UIColor.lightGray.cgColor // MainColor1가 없을 경우 기본 색상 설정
        }
        
        PasswordTextField.layer.addSublayer(bottomBorder)
    }
    
    // PasswordConfirmTextField - 디테일 설정하기
    private func configurePasswordConfirmTextField() {
        // PasswordConfirmTextField의 기본 테두리 제거
        PasswordConfirmTextField.borderStyle = .none
        
        // 새로운 하단 테두리 레이어 추가
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: PasswordConfirmTextField.frame.size.height - 1, width: PasswordConfirmTextField.frame.size.width, height: 1)
        
        // Assets에 저장된 MainColor로 하단 테두리 색상 설정
        if let mainColor = UIColor(named: "MainColor1") {
            bottomBorder.backgroundColor = mainColor.cgColor
        } else {
            bottomBorder.backgroundColor = UIColor.lightGray.cgColor // MainColor가 없을 경우 기본 색상 설정
        }
        
        PasswordConfirmTextField.layer.addSublayer(bottomBorder)
    }
    
    
    
    
    // SigninButton - 디테일 설정하기
    private func configureSigninButton() {
        
        // SigninButton을 둥글게 만들기
        SigninButton.layer.cornerRadius = 10.0
        SigninButton.clipsToBounds = true
    }
    
    
    
    
}
