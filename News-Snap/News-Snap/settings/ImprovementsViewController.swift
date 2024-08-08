//
//  ImprovementsViewController.swift
//  News-Snap
//
//  Created by 선가연 on 7/31/24.
//

import UIKit

class ImprovementsViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var dismissBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        // 모서리 둥글게 설정
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        // 테두리 설정
        contentView.layer.borderWidth = 1
        cancelBtn.layer.borderWidth = 1
        dismissBtn.layer.borderWidth = 1
    }
    
    @IBAction func cancelDidTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissDidTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
