//
//  DaySettingsViewController.swift
//  News-Snap
//
//  Created by 선가연 on 7/18/24.
//

import UIKit

class DaySettingsViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var mondayBtn: UIButton!
    
    @IBOutlet weak var tuesday: UIButton!
    
    @IBOutlet weak var wednesdayBtn: UIButton!
    
    @IBOutlet weak var thursdayBtn: UIButton!
    
    @IBOutlet weak var fridayBtn: UIButton!
    
    @IBOutlet weak var saturdayBtn: UIButton!
    
    @IBOutlet weak var sundayBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        // 모서리 둥글게 설정
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        // 테두리 설정
        contentView.layer.borderWidth = 1
        cancelBtn.layer.borderWidth = 1
        saveBtn.layer.borderWidth = 1
    }
    
    @IBAction func mondayDidTap(_ sender: UIButton) {
    }
    
    @IBAction func tuesdayDidTap(_ sender: UIButton) {
    }
    
    @IBAction func wednesdayDidTap(_ sender: UIButton) {
    }
    
    @IBAction func thursdayDidTap(_ sender: UIButton) {
    }
    
    @IBAction func fridayDidTap(_ sender: UIButton) {
    }
    
    @IBAction func saturdayDidTap(_ sender: UIButton) {
    }
    
    @IBAction func sundayDidTap(_ sender: UIButton) {
    }
    
    @IBAction func cancelDidTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveDidTap(_ sender: UIButton) {
    }
    
    
}
