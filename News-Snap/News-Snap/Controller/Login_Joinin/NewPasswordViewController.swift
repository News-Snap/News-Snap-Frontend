//
//  NewPasswordViewController.swift
//  News-Snap
//  Created by 문정현 on 7/25/24.
//  Created by 문정현 on 8/9/24.
//  새 비밀번호 서버에 보내주는 코드 만들기
//  유효성 검사 복붙
//  Invisible 버튼 설정
//  이쪽은 toggle화 제거 고려(후순위)
//  확인 버튼을 누르고 어느화면으로 갈지


import UIKit

class NewPasswordViewController: UIViewController {
    
    @IBOutlet weak var NewPasswordTF: UITextField!
    
    @IBOutlet weak var ConfirmPasswordTF: UITextField!
    
    @IBOutlet weak var ConfirmButton: UIButton!
    
    
    @IBAction func ConfirmButtonTapped(_ sender: Any) {
    }
    
    @IBAction func InvisibleButtonTapped(_ sender: Any) {
    }
    
    @IBAction func SecondInvisibleButtonTapped(_ sender: Any) {
    }
    
    @IBAction func BackButtonTapped(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true) // 이전 화면으로 넘어가는 코드
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureConfirmButton()

    }
    
    // ConfirmButton - 디테일 설정하기
    private func configureConfirmButton() {
  
    // ConfirmButton을 둥글게 만들기
        ConfirmButton.layer.cornerRadius = 10.0
        ConfirmButton.clipsToBounds = true
}
    
    




}
