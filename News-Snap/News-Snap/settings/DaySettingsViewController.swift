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
    @IBOutlet weak var tuesdayBtn: UIButton!
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
        
        initializeButtonStates()
    }
    
    // 버튼 선택 상태 초기화
    func initializeButtonStates() {
        print("selectedDays: \(selectedDays)")
        
        if selectedDays.contains("MONDAY") { mondayBtn.isSelected = true }
        if selectedDays.contains("TUESDAY") { tuesdayBtn.isSelected = true }
        if selectedDays.contains("WEDNESDAY") { wednesdayBtn.isSelected = true }
        if selectedDays.contains("THURSDAY") { thursdayBtn.isSelected = true }
        if selectedDays.contains("FRIDAY") { fridayBtn.isSelected = true }
        if selectedDays.contains("SATURDAY") { saturdayBtn.isSelected = true }
        if selectedDays.contains("SUNDAY") { sundayBtn.isSelected = true }
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
        if tuesdayBtn.isSelected {
            tuesdayBtn.isSelected = false
        }
        else {
            tuesdayBtn.isSelected = true
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
        if mondayBtn.isSelected { selectedDays.append("MONDAY") }
        if tuesdayBtn.isSelected { selectedDays.append("TUESDAY") }
        if wednesdayBtn.isSelected { selectedDays.append("WEDNESDAY") }
        if thursdayBtn.isSelected { selectedDays.append("THURSDAY") }
        if fridayBtn.isSelected { selectedDays.append("FRIDAY") }
        if saturdayBtn.isSelected { selectedDays.append("SATURDAY") }
        if sundayBtn.isSelected { selectedDays.append("SUNDAY") }

        delegate?.didSelectDays(selectedDays)
        dismiss(animated: true, completion: nil)
    }
    
    
}
