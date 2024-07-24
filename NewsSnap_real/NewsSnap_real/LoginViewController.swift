//
//  LoginViewController.swift
//  NewsSnap_real
//
//  Created by 문정현 on 7/17/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TextField를 Custom하기 위해서 필요함
        configureEmailTextField()
        configurePasswordTextField()
        // LoginButton을 둥글게 만들기 위해 호출
        configureLoginButton()
        //configureFindIDButton()
        
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
    
    //-----------------------------------------------------------
    
    
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
    
    
    //-----------------------------------------------------------
    
    
    // LoginButton - 디테일 설정하기
    private func configureLoginButton() {
        
        // LoginButton을 둥글게 만들기
        LoginButton.layer.cornerRadius = 10.0
        LoginButton.clipsToBounds = true
    }
    
    
    //------------------------------------------------------------
    
    // FindIDButton - 디테일 설정하기
    // 'MainColor'를 UIColor로 로드
//    let mainColor = UIColor(named: "MainColor")!
//    
//    // 밑줄이 있는 텍스트 생성
//    let buttonTitle = "FindIDButton"
//    let attributedString = NSAttributedString(string: FindIDButton, attributes: [
//        NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
//        NSAttributedString.Key.underlineColor: MainColor
//    ])
//    
//    // UIButton에 attributedTitle 설정
//    FindIDButton.setAttributedTitle(attributedString, for: .normal)
//    
//    // 테두리를 둥글게 만들기
//    FindIDButton.layer.cornerRadius = 10.0
//    FindIDButton.clipsToBounds = true
//    
}
    

