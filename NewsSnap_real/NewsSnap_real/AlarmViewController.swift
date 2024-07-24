//
//  AlarmViewController.swift
//  NewsSnap_real
//
//  Created by 문정현 on 7/17/24.
//

import UIKit

class AlarmViewController: UIViewController {
    
    @IBOutlet weak var FirstView: UIView!
    
    @IBOutlet weak var SecondView: UIView!
    
    
    @IBAction func AdmitButton(_ sender: Any) {
    }
    
    @IBAction func DisAdmitButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      

    // FirstTableView - 디테일 설정하기
    FirstView.layer.borderColor = UIColor.gray.cgColor
    FirstView.layer.borderWidth = 1.0
    FirstView.layer.cornerRadius = 15.0
    FirstView.layer.masksToBounds = true
        
        
        
    // SecondTableView - 디테일 설정하기
    SecondView.layer.borderColor = UIColor.gray.cgColor
    SecondView.layer.borderWidth = 1.0
    SecondView.layer.cornerRadius = 15.0
    SecondView.layer.masksToBounds = true
    

    // AdmitButton - 디테일 설정하기
    AdmitButton.layer.borderColor = UIColor.gray.cgColor
    AdmitButton.layer.borderWidth = 1.0
    AdmitButton.layer.cornerRadius = 15.0
    AdmitButton.layer.masksToBounds = true
        
    // DisAdmitButton - 디테일 설정하기
    DisAdmitButton.layer.borderColor = UIColor.gray.cgColor
    DisAdmitButton.layer.borderWidth = 1.0
    DisAdmitButton.layer.cornerRadius = 15.0
    DisAdmitButton.layer.masksToBounds = true

    }
    

  

}
