//
//  ScrapDetailedViewController.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 8/27/24.
//

import UIKit

class ScrapDetailedViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Outlet
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var keywordCollectionView: UICollectionView!
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var attachmentFile: UIButton!
    @IBOutlet weak var relatedMediaCollectionView: UICollectionView!
    
    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testButton()
        
        // 키워드 생성
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
        let keywordNib = UINib(nibName: "KeywordCollectionViewCell", bundle: nil)
        keywordCollectionView.register(keywordNib, forCellWithReuseIdentifier: "KeywordCollectionViewCell")

        // Content 설정
        contentTableView.delegate = self
        contentTableView.dataSource = self
        let contentNib = UINib(nibName: "ContentTableViewCell", bundle: nil)
        contentTableView.register(contentNib, forCellReuseIdentifier: "ContentTableViewCell")
        
        // Related Media 설정
        relatedMediaCollectionView.delegate = self
        relatedMediaCollectionView.dataSource = self
        let relatedNib = UINib(nibName: "RelatedMediaCollectionViewCell", bundle: nil)
        relatedMediaCollectionView.register(relatedNib, forCellWithReuseIdentifier: "RelatedMediaCollectionViewCell")
        
        
    }
    



    // MARK: - Action
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func viewDetailedButtonTapped(_ sender: Any) {
    }
    
    
    // MARK: - Function
    
    func testButton() {
        let update = UIAction(title: "수정하기", handler: { [weak self] _ in
            print("수정하기")
            self?.navigateToUpdateVC()
        })
        
        let share = UIAction(title: "공유하기", handler: { [weak self] _ in
            print("공유하기")
            //self?.navigateToOtherViewController()
        })
        
        let delete = UIAction(title: "삭제하기", attributes: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }  // self가 nil이 아닌지 확인
            
            self.deleteScrap(scrapId: "1", completion: { success in
                DispatchQueue.main.async {
                    if success {
                        print("스크랩이 성공적으로 삭제되었습니다.")
                        
                        // 필요한 경우 UI 업데이트 (예: 목록에서 해당 항목 제거)
                        if let navigationController = self.navigationController {
                            navigationController.popViewController(animated: true)
                        } else {
                            print("Navigation controller is nil.")
                        }
                        
                    } else {
                        print("스크랩 삭제에 실패했습니다.")
                        
                        // 사용자에게 알림 표시
                        let alert = UIAlertController(title: "Error", message: "스크랩을 삭제할 수 없습니다.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                    }
                }
            })
        })
        
        let menu = UIMenu(title: "", children: [update, share, delete])
        menuButton.menu = menu
    }
    
    func navigateToUpdateVC() {
        guard let updateVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateScrapViewController") as? CreateScrapViewController else {
            return
        }
        updateVC.modalTransitionStyle = .coverVertical
        updateVC.modalPresentationStyle = .overFullScreen
        self.present(updateVC, animated: true, completion: nil)
    }
    
    func deleteScrap(scrapId: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://52.78.37.90:8080/api/v1/scrap/5") else {
            print("Invalid URL")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error occurred: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    print("Success: \(httpResponse.statusCode)")
                    DispatchQueue.main.async {
                        completion(true)
                    }
                } else {
                    print("Failed with status code: \(httpResponse.statusCode)")
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            } else {
                print("No HTTP response received")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
        
        task.resume()
    }
}


// 키워드 CollectionView 설정
extension ScrapDetailedViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return 3
        }
        else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCollectionViewCell", for: indexPath) as? KeywordCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RelatedMediaCollectionViewCell", for: indexPath) as? RelatedMediaCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
    }
    
    
//    // 셀 간의 간격 설정
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        if collectionView.tag == 0 {
//            return 4
//        }
//        else {
//            return 5
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 153)
    }
    
    
    // 셀 선택 시 호출되는 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            print("KeywordCollectionViewCell \(indexPath.row) 선택됨")
            // 여기에 원하는 액션을 추가하세요
            // 예: 다른 뷰 컨트롤러로 이동, 알림 표시, 데이터 처리 등
        } else {
            print("RelatedMediaCollectionViewCell \(indexPath.row) 선택됨")
            // 다른 액션 추가
        }
    }
}


// Content TableView 설정
extension ScrapDetailedViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell", for: indexPath) as? ContentTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
