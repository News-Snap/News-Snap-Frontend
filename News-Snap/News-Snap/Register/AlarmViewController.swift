//
//  AlarmViewController.swift
//  News-Snap
//  Created by 문정현 on 7/17/24.
//  Created by 문정현 on 8/9/24.
//


import UIKit
import UserNotifications

class AlarmViewController: UIViewController {
    
    @IBOutlet weak var FirstView: UIView!
    
    
    @IBOutlet weak var SecondView: UIView!
    
    
    @IBOutlet weak var AdmitButton: UIButton!
    
    @IBOutlet weak var DisAdmitButton: UIButton!
    
    
    
    @IBAction func AdmitButtonTapped(_ sender: Any) {
        configureButtonUI(button: sender as! UIButton)
        
        // 알림 권란을 요청하는 함수
        requestNotificationPermission()
        // AdmitButtonTapped에 SendPushNotificationPreferenceToServer 함수가 없어도 "허용" 버튼을 눌렀다는 Data는 Server에 전송됨 _ 이유는?
    }
    
    @IBAction func DisAdmitButtonTapped(_ sender: Any) {
        configureButtonUI(button: sender as! UIButton)
        // "허용 안함" 버튼을 눌렀을 때 서버에 알림 허용 여부 전달
        
        // 함수를 호출하여 서버에 권한 상태를 전송하는 코드
        sendPushNotificationPreferenceToServer(isAllowed: false)
        
        // 알람이 허용되지 않았음을 알리는 팝업 메시지 표시 및 화면 전환 ( 화면전환과 관련된 코드는 override 코드 밖에 존재_최하단 참고 )
        showAlert(message: "알람이 허용되지 않았습니다.") {
                    self.navigateToSelectViewController()
                }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // FirstTableView - 디테일 설정하기
        FirstView.layer.borderColor = UIColor.gray.cgColor
        FirstView.layer.borderWidth = 1.0
        FirstView.layer.cornerRadius = 15.0
        FirstView.layer.masksToBounds = true
        
        
        
        // SecondTableView - 디테일 설정하기
        SecondView.layer.borderColor = UIColor.gray.cgColor
        SecondView.layer.borderWidth = 1.0
        SecondView.layer.cornerRadius = 15.0
        SecondView.layer.masksToBounds = true
        
        
        
        
        
        // AdmitButton - 디테일 설정하기
        AdmitButton.layer.borderColor = UIColor.gray.cgColor
        AdmitButton.layer.borderWidth = 1.0
        AdmitButton.layer.cornerRadius = 17.5
        AdmitButton.layer.masksToBounds = true
        
        // DisAdmitButton - 디테일 설정하기
        DisAdmitButton.layer.borderColor = UIColor.gray.cgColor
        DisAdmitButton.layer.borderWidth = 1.0
        DisAdmitButton.layer.cornerRadius = 17.5
        DisAdmitButton.layer.masksToBounds = true
        
        
        
        
        
        
    }
    
    func configureButtonUI(button: UIButton) {
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 17.5
        button.layer.masksToBounds = true
    }
    
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("알림 권한 요청 오류: \(error)")
                return
                }
                print("알림 권한 허용됨: \(granted)")
                DispatchQueue.main.async {
            if granted {
                self.scheduleDailyNotification()
                self.sendPushNotificationPreferenceToServer(isAllowed: true)
                // 알람 허용 시 팝업 메시지를 표시하고, SelectViewController로 화면 전환
                self.showAlert(message: "알람이 허용되었습니다.") {
                self.navigateToSelectViewController()
                        }
            } else {
                self.sendPushNotificationPreferenceToServer(isAllowed: false)
                // 알람 비허용 시 팝업 메시지를 표시하고, SelectViewController로 화면 전환
                self.showAlert(message: "알람이 허용되지 않았습니다.") {
                self.navigateToSelectViewController()
                        }
                    }
                }
            }
        }

    func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
            content.title = "스크랩할 시간입니다!"
            content.body = "매일 오전 9시에 스크랩 독려 알람이 갑니다."
            content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
            dateComponents.hour = 9
            dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyScrapReminder", content: content, trigger: trigger)

        let center = UNUserNotificationCenter.current()
            center.add(request) { error in
                if let error = error {
                    print("알림 예약 오류: \(error)")
            } else {
                    print("알림 예약 성공.")
                }
            }
        }
    // 서버에 알람 허용 여부 데이터 전송 코드 _ 추후 확인 필요
    func sendPushNotificationPreferenceToServer(isAllowed: Bool) {
        let url = URL(string: "https://yourapi.com/notification_preference")!
        var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["user_id": "currentUserID", "is_allowed": isAllowed]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                    print("Error sending push notification preference to server: \(error)")
            return
                }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    print("Push notification preference updated successfully.")
          } else {
                    print("Failed to update push notification preference.")
                }
            }

            task.resume()
    }
        
        // 팝업 메시지를 표시하는 함수
    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                completion?()
            })
            present(alert, animated: true, completion: nil)
        }
        
        // SelectViewController로 화면 전환하는 함수
    func navigateToSelectViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let selectVC = storyboard.instantiateViewController(withIdentifier: "SelectVC") as? SelectViewController {
                selectVC.modalTransitionStyle = .crossDissolve
                selectVC.modalPresentationStyle = .fullScreen
                present(selectVC, animated: true, completion: nil)
            }
        }
    }

