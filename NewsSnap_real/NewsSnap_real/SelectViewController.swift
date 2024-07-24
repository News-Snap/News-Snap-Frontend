//
//  SelectViewController.swift
//  NewsSnap_real
//
//  Created by 문정현 on 7/16/24.
//

import UIKit

class SelectViewController: UIViewController {

    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // GoogleView의 모양을 원으로 만들기 ( 뒷베경 설정 code )
        GoogleView.layer.cornerRadius = GoogleView.frame.size.width / 2
        GoogleView.layer.masksToBounds = true
        
    }
    

}
