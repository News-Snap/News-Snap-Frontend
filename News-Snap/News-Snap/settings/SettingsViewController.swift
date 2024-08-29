//
//  SettingsViewController.swift
//  News-Snap
//
//  Created by 선가연 on 7/17/24.
//

import UIKit

class SettingsViewController: UIViewController, DaySettingsDelegate, TimeSettingsDelegate {
    
    // 요일 설정 체크박스 상태 유지, 푸시 알림
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameChangeBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var pushAlertBtn: UIButton!
    @IBOutlet weak var settingDayBtn: UIButton!
    @IBOutlet weak var selectecDayLabel: UILabel!
    @IBOutlet weak var settingTimeBtn: UIButton!
    @IBOutlet weak var selectedTimeLabel: UILabel!

    var selectedDays: [String] = []
    var selectedTime: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 모서리 둥글게 설정
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
    }
    
    // 닉네임 수정 버튼
    @IBAction func editUsernameDidTap(_ sender: UIButton) {
    }
    
    // 로그아웃 버튼
    @IBAction func logoutDidTap(_ sender: UIButton) {
    }
    
    
    @IBAction func pushAlertDidTap(_ sender: UIButton) {
        
        if pushAlertBtn.isSelected {
            pushAlertBtn.isSelected = false
        }
        else {
            pushAlertBtn.isSelected = true
        }
    }
    
    
    func didSelectDays(_ selectedDays: [String]) {
        self.selectedDays = selectedDays
        selectecDayLabel.text = selectedDays.joined(separator: ", ")
    }
    
    func didSelectTime(_ selectedTime: String) {
            self.selectedTime = selectedTime
            selectedTimeLabel.text = selectedTime
    }
    
    // 요일 설정 버튼
    @IBAction func settingDayDidTap(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "DaySettingsViewController") as? DaySettingsViewController else { return }
        
        nextVC.delegate = self
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    // 시간 설정 버튼
    @IBAction func settingTimeDidTap(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "TimeSettingsViewController") as? TimeSettingsViewController else { return }
        
        nextVC.delegate = self
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
}
