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
        // 0.5초 후에 화면 전환
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigateToAlarmViewController()
                }
            }
            
        func navigateToAlarmViewController() {
            if let alarmVC = storyboard?.instantiateViewController(withIdentifier: "AlarmVC") as? AlarmViewController {
                    self.navigationController?.pushViewController(alarmVC, animated: true)
                }
            }
        }
    
