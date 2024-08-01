//
//  SelectViewController.swift
//  NewsSnap_real
//
//  Created by 문정현 on 7/16/24.
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Background 뷰를 둥글게 만들기
            Background.layer.cornerRadius = Background.frame.size.height / 2
            Background.layer.masksToBounds = true
        
        
        
    }

}
