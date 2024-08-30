//
//  StartViewController.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 7/16/24.
//  Created by Jh 

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 스플래시 화면을 2초 동안 보여주고 AlarmViewController로 전환
               DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                   self.goToAlarmViewController()
               }
           }
           
           func goToAlarmViewController() {
               // Storyboard ID를 사용해 AlarmViewController 인스턴스를 가져옴
               if let alarmVC = self.storyboard?.instantiateViewController(withIdentifier: "AlarmVC") as? AlarmViewController {
                   // 화면 전환 애니메이션을 설정하려면 아래 코드를 사용
                   alarmVC.modalTransitionStyle = .crossDissolve
                   alarmVC.modalPresentationStyle = .fullScreen
                   self.present(alarmVC, animated: true, completion: nil)
               }
           }
       }


