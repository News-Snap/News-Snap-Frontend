//
//  NewPasswordViewController.swift
//  NewsSnap_real
//
//  Created by 문정현 on 7/25/24.
//

import UIKit

class NewPasswordViewController: UIViewController {

    @IBOutlet weak var NewPasswordTextfield: UITextField!
    @IBOutlet weak var PasswordconfirmTextField: UITextField!
    
    @IBOutlet weak var ConfirmButton: UIButton!
    
    @IBAction func ConfirmButton(_ sender: Any) {
    }
    
    @IBAction func InvisibleButton(_ sender: Any) {
    }
    
    @IBAction func ConfirmInvisibleButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNewPasswordTextField()
        configurePasswordConfirmTextField()
        configureButton()
        
    }
    
    // NewPasswordTextfield - 디테일 설정하기
    private func configureNewPasswordTextField() {
        // NewPasswordTextfield의 기본 테두리 제거
        NewPasswordTextfield.borderStyle = .none
        
        // 새로운 하단 테두리 레이어 추가
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: NewPasswordTextfield.frame.size.height - 1, width: NewPasswordTextfield.frame.size.width, height: 1)
        
        // Assets에 저장된 MainColor로 하단 테두리 색상 설정
        if let mainColor = UIColor(named: "MainColor") {
            bottomBorder.backgroundColor = mainColor.cgColor
        } else {
            bottomBorder.backgroundColor = UIColor.black.cgColor // MainColor가 없을 경우 기본 색상 설정
        }
        
        NewPasswordTextfield.layer.addSublayer(bottomBorder)
    }
    
    // PasswordconfirmTextField - 디테일 설정하기
    private func configurePasswordConfirmTextField() {
        // PasswordconfirmTextField의 기본 테두리 제거
        PasswordconfirmTextField.borderStyle = .none
        
        // 새로운 하단 테두리 레이어 추가
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: PasswordconfirmTextField.frame.size.height - 1, width: PasswordconfirmTextField.frame.size.width, height: 1)
        
        // Assets에 저장된 MainColor로 하단 테두리 색상 설정
        if let mainColor = UIColor(named: "MainColor1") {
            bottomBorder.backgroundColor = mainColor.cgColor
        } else {
            bottomBorder.backgroundColor = UIColor.lightGray.cgColor // MainColor1가 없을 경우 기본 색상 설정
        }
        
        PasswordconfirmTextField.layer.addSublayer(bottomBorder)
        
    }
    
    
    
    
    
    // ConfirmButton - 디테일 설정하기
    private func configureButton() {
        
        // ConfirmButton을 둥글게 만들기
        ConfirmButton.layer.cornerRadius = 10.0
        ConfirmButton.clipsToBounds = true
    }
    



}
