//
//  EmailVerificationViewController.swift
//  News-Snap
//  Created by 문정현 on 7/25/24.
//  Created by 문정현 on 8/9/24.
//

import UIKit

class EmailVerificationViewController: UIViewController {

    
    
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var AuthButton: UIButton!
    @IBOutlet weak var AuthNumTextField: UITextField!
    @IBOutlet weak var ConfirmButton: UIButton!
    
    
    // 화면전환이 안되는 오류 발생
    @IBAction func ConfirmButtonTapped(_ sender: Any) {
        guard let NewPasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewPasswordVC") as? NewPasswordViewController else { return }
                // 화면 전환 애니메이션 설정
        NewPasswordViewController.modalTransitionStyle = .coverVertical
                // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        NewPasswordViewController.modalPresentationStyle = .fullScreen
                self.present(NewPasswordViewController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func AuthButtonTapped(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAuthButton()
        configureConfirmButton()
        


    }

    
    
    // AuthButton - 디테일 설정하기
    private func configureAuthButton() {

         //AuthButton을 둥글게 만들기
        AuthButton.layer.cornerRadius = 10.0
        AuthButton.clipsToBounds = true
    }

   //  ConfirmButton - 디테일 설정하기
    private func configureConfirmButton() {
        
        // ConfirmButton을 둥글게 만들기
        ConfirmButton.layer.cornerRadius = 10.0
        ConfirmButton.clipsToBounds = true
    }
    
   


}
