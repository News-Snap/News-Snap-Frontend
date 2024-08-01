//
//  EmailVerificationViewController.swift
//  NewsSnap_real
//
//  Created by 문정현 on 7/25/24.
//

import UIKit

class EmailVerificationViewController: UIViewController {

    
    @IBOutlet weak var NameTextField: UITextField!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var AuthnumberTextField: UITextField!
    
    
    @IBOutlet weak var AuthButton: UIButton!
    
    @IBOutlet weak var InvisibleButton: UIButton!
    
    @IBOutlet weak var ConfirmButton: UIButton!
    
    @IBAction func ConfirmButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNameTextField()
        configureEmailTextField()
        configureAuthButton()
        configureAuthnumberTextField()
        configureConfirmButton()


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
    
  
    // AuthButton - 디테일 설정하기
    private func configureAuthButton() {
        
        // AuthButton을 둥글게 만들기
        AuthButton.layer.cornerRadius = 10.0
        AuthButton.clipsToBounds = true
    }
    
    
    
    // AuthnumberTextField - 디테일 설정하기
    private func configureAuthnumberTextField() {
        // AuthnumberTextField의 기본 테두리 제거
        AuthnumberTextField.borderStyle = .none
        
        // 새로운 하단 테두리 레이어 추가
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: AuthnumberTextField.frame.size.height - 1, width: AuthnumberTextField.frame.size.width, height: 1)
        
        // Assets에 저장된 MainColor로 하단 테두리 색상 설정
        if let mainColor = UIColor(named: "MainColor1") {
            bottomBorder.backgroundColor = mainColor.cgColor
        } else {
            bottomBorder.backgroundColor = UIColor.black.cgColor // MainColor가 없을 경우 기본 색상 설정
        }
        
        AuthnumberTextField.layer.addSublayer(bottomBorder)
    }
    
    // ConfirmButton - 디테일 설정하기
    private func configureConfirmButton() {
        
        // ConfirmButton을 둥글게 만들기
        ConfirmButton.layer.cornerRadius = 10.0
        ConfirmButton.clipsToBounds = true
    }
    
    
    


}
