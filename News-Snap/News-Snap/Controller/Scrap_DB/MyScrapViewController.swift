//
//  MyScrapViewController.swift
//  News-Snap
//
//  Created by 문정현 on 8/12/24.
//  UIPageeControl 설정하기
//  MakeScrapTapped 화면전환 설정하기
//  TabBar랑 NavigateController 연결하기

import UIKit

class MyScrapViewController: UIViewController {
    
    // Outlet //
    @IBOutlet weak var NewsTableView: UITableView!
    
    
    
    // Action //
    @IBAction func SearchByCalenderTapped(_ sender: Any) {
    }
    @IBAction func MakeScrapTapped(_ sender: Any) {
    }
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
    @IBAction func PageControl(_ sender: Any) {
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NewsTableView.delegate = self
        NewsTableView.dataSource = self
        NewsTableView.separatorStyle = .none // 클릭했을 때 자동색상 변환 지우기
        
        
        
        
        // NIB 파일 등록
        let feedNib = UINib(nibName: "EachNewsTableViewCell", bundle: nil)
        NewsTableView.register(feedNib, forCellReuseIdentifier: "EachNewsTableViewCell")
    }
    
    
    
}
        
    // 한 섹션에 몇 개의 Cell을 넣을거냐? //
extension MyScrapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    // 어떤 Cell을 보여줄 것이냐? //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = NewsTableView.dequeueReusableCell(withIdentifier: "EachNewsTableViewCell", for: indexPath) as? EachNewsTableViewCell else {
            return UITableViewCell()
            
        }
        cell.selectionStyle = .none
//        cell.imageViewFeed ( 이제 Cell 안에 있는 모든 아울렛들을 설정 가능해짐 )
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70          // TableViewCell 크기 강제 조정
    }
    
    
}
