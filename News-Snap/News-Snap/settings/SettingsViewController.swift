//
//  SettingsViewController.swift
//  News-Snap
//
//  Created by 선가연 on 7/17/24.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var usernameChangeBtn: UIButton!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var pushAlertBtn: UIButton!
    
    @IBOutlet weak var settingDayBtn: UIButton!
    
    @IBOutlet weak var selectecDayLabel: UILabel!
    
    @IBOutlet weak var settingTimeBtn: UIButton!
    
    @IBOutlet weak var selectedTimeLabel: UILabel!
    
    @IBOutlet weak var googleDriveBtn: UIButton!
    
    @IBOutlet weak var toMainBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 모서리 둥글게 설정
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        toMainBtn.layer.cornerRadius = 10
        toMainBtn.layer.masksToBounds = true
    }
    
    @IBAction func editUsernameDidTap(_ sender: UIButton) {
    }
    
    @IBAction func logoutDidTap(_ sender: UIButton) {
    }
    
    @IBAction func settingDayDidTap(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "DaySettingsViewController") as? DaySettingsViewController else { return }
        
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .overFullScreen
        // nextVC.preferredContentSize = CGSize(width: 300, height: 400)
        self.present(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func settingTimeDidTap(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "TimeSettingsViewController") as? TimeSettingsViewController else { return }
        
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func googleDriveDidTap(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "GoogleDriveSettingViewController") as? GoogleDriveSettingViewController else { return }
        
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
}
