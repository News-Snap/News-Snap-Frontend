//
//  TimeSettingsViewController.swift
//  News-Snap
//
//  Created by 선가연 on 7/18/24.
//

import UIKit

protocol TimeSettingsDelegate: AnyObject {
    func didSelectTime(_ selectedTime: String)
}

class TimeSettingsViewController: UIViewController {
    
    weak var delegate: TimeSettingsDelegate?
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
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
    
    @IBAction func cancelDidTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveDidTap(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeStyle = .short
        let selectedTime = formatter.string(from: datePicker.date)
                
        delegate?.didSelectTime(selectedTime)
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
