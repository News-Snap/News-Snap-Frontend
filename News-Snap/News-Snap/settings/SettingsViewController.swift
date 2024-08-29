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
        
        fetchSettingsData()
    }
    
    func fetchSettingsData() {
        let urlString = "http://52.78.37.90:8080/api/v1/setting"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let token = ""
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                print("JSON Response: \(jsonResponse)")
                
                if let dictionary = jsonResponse as? [String: Any],
                   let result = dictionary["result"] as? [String: Any] {
                    DispatchQueue.main.async {
                        self.updateUI(with: result)
                    }
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                if let dataString = String(data: data, encoding: .utf8) {
                    print("Received data: \(dataString)")
                }
            }
        }
        
        task.resume()
    }
    
    func updateUI(with result: [String: Any]) {
        // 닉네임 설정
        if let nickname = result["nickname"] as? String {
            usernameLabel.text = nickname
        }
        
        // 푸시 알림 설정
        if let pushAlarm = result["pushAlarm"] as? Bool {
            pushAlertBtn.isSelected = pushAlarm
        }
        
        // 알림 요일 설정
        if let alarmDays = result["alarmDay"] as? [String] {
            selectedDays = alarmDays
            selectecDayLabel.text = alarmDays.joined(separator: ", ")
        }
        
        // 알림 시간 설정
        if let alarmTime = result["alarmTime"] as? [String: Any],
           let hour = alarmTime["hour"] as? Int,
           let minute = alarmTime["minute"] as? Int {
            let timeString = String(format: "%02d:%02d", hour, minute)
            selectedTime = timeString
            selectedTimeLabel.text = timeString
        }
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
