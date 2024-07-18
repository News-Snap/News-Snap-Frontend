//
//  StartViewController.swift
//  NewsSnap_real
//
//  Created by 문정현 on 7/16/24.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2초 후에 자동으로 AlarmViewController로 전환
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.navigateToAlarmViewController()
        }
    }

    func navigateToAlarmViewController() {
        // Storyboard 인스턴스 생성
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // AlarmViewController 인스턴스 생성
        if let alarmViewController = storyboard.instantiateViewController(withIdentifier: "AlarmViewController") as? AlarmViewController {
            // 전환 애니메이션을 위해 present 메서드 사용
            alarmViewController.modalTransitionStyle = .crossDissolve
            alarmViewController.modalPresentationStyle = .fullScreen
            self.present(alarmViewController, animated: true, completion: nil)
        }
    }
}
