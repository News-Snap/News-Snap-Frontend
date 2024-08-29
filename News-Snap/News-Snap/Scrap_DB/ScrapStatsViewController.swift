//
//  ScrapStatsViewController.swift
//  News-Snap
//
//  Created by 문정현 on 8/12/24.
//  UI 디테일 설정 끝 완성
//  오늘 다시 보지 않기 설정하기
//  다른 화면에서 홈(TabBarController)로 화면전환될 때 해당 VC 거치도록 설정하기

import UIKit

class ScrapStatsViewController: UIViewController {

    // Outlet // --- UIView
    @IBOutlet weak var TotalScrap: UIView!
    @IBOutlet weak var WeekAverageScrap: UIView!
    @IBOutlet weak var OftenUseKeyword: UIView!
    @IBOutlet weak var HighRankPercent: UIView!
    
    
    
    // Outlet // --- Label쪽 API
    @IBOutlet weak var TotalScrapNumber: UILabel!
    @IBOutlet weak var WeekAverageScrapNumber: UILabel!
    @IBOutlet weak var HashTagKeyword: UILabel!
    @IBOutlet weak var Percent: UILabel!
    
    
    
    // Action // --- 화면전환
    @IBAction func BackButtonTapped(_ sender: Any) {
        // 스토리보드에서 TabBarController를 인스턴스화
        guard let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else {
            return
        }
        // 화면 전환 애니메이션 설정 (원하는 애니메이션 스타일로 변경 가능)
        tabBarController.modalTransitionStyle = .coverVertical
        // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        tabBarController.modalPresentationStyle = .fullScreen
        // 화면 전환 수행
        self.present(tabBarController, animated: true, completion: nil)
    }
    
    
    @IBAction func DoNotShowTodayButtonTapped(_ sender: Any) {
        // 스토리보드에서 TabBarController를 인스턴스화
        guard let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else {
            return
        }
        // 화면 전환 애니메이션 설정 (원하는 애니메이션 스타일로 변경 가능)
        tabBarController.modalTransitionStyle = .coverVertical
        // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        tabBarController.modalPresentationStyle = .fullScreen
        // 화면 전환 수행
        self.present(tabBarController, animated: true, completion: nil)
    }
    
    
    
    
          
    override func viewDidLoad() {
           super.viewDidLoad()
           
           // 새로운 코드 //
           // 각 UIView에 회색 테두리와 둥근 모서리를 추가
           let borderColor = UIColor.lightGray.cgColor // 테두리 색상 설정
           let borderWidth: CGFloat = 1.0              // 테두리 두께 설정
           let cornerRadius: CGFloat = 10.0            // 둥근 모서리 반경 설정
           
           // TotalScrap 뷰 설정
           TotalScrap.layer.borderColor = borderColor
           TotalScrap.layer.borderWidth = borderWidth
           TotalScrap.layer.cornerRadius = cornerRadius
           TotalScrap.layer.masksToBounds = true
           
           // WeekAverageScrap 뷰 설정
           WeekAverageScrap.layer.borderColor = borderColor
           WeekAverageScrap.layer.borderWidth = borderWidth
           WeekAverageScrap.layer.cornerRadius = cornerRadius
           WeekAverageScrap.layer.masksToBounds = true
           
           // OftenUseKeyword 뷰 설정
           OftenUseKeyword.layer.borderColor = borderColor
           OftenUseKeyword.layer.borderWidth = borderWidth
           OftenUseKeyword.layer.cornerRadius = cornerRadius
           OftenUseKeyword.layer.masksToBounds = true
           
           // HighRankPercent 뷰 설정
           HighRankPercent.layer.borderColor = borderColor
           HighRankPercent.layer.borderWidth = borderWidth
           HighRankPercent.layer.cornerRadius = cornerRadius
           HighRankPercent.layer.masksToBounds = true
           // 새로운 코드 끝 //
       }
   }




