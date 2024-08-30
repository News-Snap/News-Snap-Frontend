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
    
    let token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZXN0QG5hdmVyLmNvbSIsImlzcyI6Ik5FV1NTTkFQIiwiaWF0IjoxNzI0OTU0MTI5LCJleHAiOjE3MjUwNDA1Mjl9.8W6rtTnbaa9_iHUk9zfCtzosLwZsUYBCzCof1uCztQsIYcr-_UjJruf8u6BQZ0gDLjkIAexMFTA3HR5nQxJxEg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 모서리 둥글게 설정
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        fetchSettingsData()
    }
    
    // 설정사항 조회
    func fetchSettingsData() {
        let urlString = "http://52.78.37.90:8080/api/v1/setting"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
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
    
    func updateAlarmDays() {
        let urlString = "http://52.78.37.90:8080/api/v1/setting/day"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 설정된 알람 요일 데이터를 JSON으로 변환
        let alarmDays = ["alarmDay": selectedDays]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: alarmDays, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error converting alarm days to JSON: \(error.localizedDescription)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }

            guard let data = data, error == nil else {
                print("Error sending data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let dataString = String(data: data, encoding: .utf8) {
                print("Received Data: \(dataString)")
            }
        }
        
        task.resume()
    }

    func updateAlarmTime() {
        let urlString = "http://52.78.37.90:8080/api/v1/setting/time"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 설정된 알람 시간을 JSON으로 변환
        let alarmTime = ["alarmTime": selectedTime]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: alarmTime, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error converting alarm time to JSON: \(error.localizedDescription)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }

            guard let data = data, error == nil else {
                print("Error sending data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let dataString = String(data: data, encoding: .utf8) {
                print("Received Data: \(dataString)")
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
        if let alarmTime = result["alarmTime"] as? String {
            selectedTime = alarmTime
            selectedTimeLabel.text = alarmTime
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
        
        updateAlarmDays()
    }
    
    func didSelectTime(_ selectedTime: String) {
        self.selectedTime = selectedTime
        selectedTimeLabel.text = selectedTime
        
        updateAlarmTime()
    }
    
    // 요일 설정 버튼
    @IBAction func settingDayDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(identifier: "DaySettingsViewController") as? DaySettingsViewController else { return }
        
        nextVC.delegate = self
        nextVC.selectedDays = self.selectedDays
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
