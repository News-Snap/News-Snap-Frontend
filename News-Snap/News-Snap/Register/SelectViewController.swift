//
//  SelectViewController.swift
//  News-Snap
//  Created by 문정현 on 7/16/24.
//  Created by 문정현 on 8/9/24.
//


import UIKit

class SelectViewController: UIViewController {
    
    @IBOutlet weak var Background: UIView!
    
    
    
    @IBAction func GoogleButton(_ sender: Any) {
    }
    
    @IBAction func KakaoButton(_ sender: Any) {
    }
    
    @IBAction func NaverButton(_ sender: Any) {
    }
    
    @IBAction func AppleButton(_ sender: Any) {
    }
    
    @IBAction func GuestButton(_ sender: Any) {
        
        guard let RegisterViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as? RegisterViewController else { return }
                // 화면 전환 애니메이션 설정
        RegisterViewController.modalTransitionStyle = .coverVertical
                // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        RegisterViewController.modalPresentationStyle = .fullScreen
                self.present(RegisterViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func LoginButtonTapped(_ sender: Any) {
        guard let LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginViewController else { return }
                // 화면 전환 애니메이션 설정
        LoginViewController.modalTransitionStyle = .coverVertical
                // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        LoginViewController.modalPresentationStyle = .fullScreen
                self.present(LoginViewController, animated: true, completion: nil)
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Background 뷰를 둥글게 만들기
            Background.layer.cornerRadius = Background.frame.size.height / 2
            Background.layer.masksToBounds = true
        
      
        
        
    }

}
