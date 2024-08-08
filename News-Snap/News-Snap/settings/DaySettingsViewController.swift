//
//  DaySettingsViewController.swift
//  News-Snap
//
//  Created by 선가연 on 7/18/24.
//

import UIKit

protocol DaySettingsDelegate: AnyObject {
    func didSelectDays(_ selectedDays: [String])
}

class DaySettingsViewController: UIViewController {
    
    weak var delegate: DaySettingsDelegate?
    var selectedDays: [String] = []
    
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
        
        // initializeButtonStates()
    }
    
    @IBAction func mondayDidTap(_ sender: UIButton) {
        if mondayBtn.isSelected {
            mondayBtn.isSelected = false
        }
        else {
            mondayBtn.isSelected = true
        }
    }
    
    @IBAction func tuesdayDidTap(_ sender: UIButton) {
        if thursdayBtn.isSelected {
            thursdayBtn.isSelected = false
        }
        else {
            thursdayBtn.isSelected = true
        }
    }
    
    @IBAction func wednesdayDidTap(_ sender: UIButton) {
        if wednesdayBtn.isSelected {
            wednesdayBtn.isSelected = false
        }
        else {
            wednesdayBtn.isSelected = true
        }
    }
    
    @IBAction func thursdayDidTap(_ sender: UIButton) {
        if thursdayBtn.isSelected {
            thursdayBtn.isSelected = false
        }
        else {
            thursdayBtn.isSelected = true
        }
    }
    
    @IBAction func fridayDidTap(_ sender: UIButton) {
        if fridayBtn.isSelected {
            fridayBtn.isSelected = false
        }
        else {
            fridayBtn.isSelected = true
        }
    }
    
    @IBAction func saturdayDidTap(_ sender: UIButton) {
        if saturdayBtn.isSelected {
            saturdayBtn.isSelected = false
        }
        else {
            saturdayBtn.isSelected = true
        }
    }
    
    @IBAction func sundayDidTap(_ sender: UIButton) {
        if sundayBtn.isSelected {
            sundayBtn.isSelected = false
        }
        else {
            sundayBtn.isSelected = true
        }
    }
    
    @IBAction func cancelDidTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveDidTap(_ sender: UIButton) {
        var selectedDays = [String]()
        if mondayBtn.isSelected { selectedDays.append("월") }
        if tuesday.isSelected { selectedDays.append("화") }
        if wednesdayBtn.isSelected { selectedDays.append("수") }
        if thursdayBtn.isSelected { selectedDays.append("목") }
        if fridayBtn.isSelected { selectedDays.append("금") }
        if saturdayBtn.isSelected { selectedDays.append("토") }
        if sundayBtn.isSelected { selectedDays.append("일") }

        delegate?.didSelectDays(selectedDays)
        dismiss(animated: true, completion: nil)
    }
    
    
}
