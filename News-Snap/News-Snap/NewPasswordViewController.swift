//
//  NewPasswordViewController.swift
//  News-Snap
//  Created by 문정현 on 7/25/24.
//  Created by 문정현 on 8/9/24.
//


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
