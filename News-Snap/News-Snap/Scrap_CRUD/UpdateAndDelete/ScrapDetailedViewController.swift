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
            self?.deleteScrap(scrapId: "1", completion: { success in
                DispatchQueue.main.async {
                    if success {
                        print("스크랩이 성공적으로 삭제되었습니다.")
                        // 필요한 경우 UI 업데이트 (예: 목록에서 해당 항목 제거)
                        self?.navigationController?.popViewController(animated: true)
                    } else {
                        print("스크랩 삭제에 실패했습니다.")
                        // 사용자에게 알림 표시
                        let alert = UIAlertController(title: "Error", message: "스크랩을 삭제할 수 없습니다.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(alert, animated: true)
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
        // API의 URL을 작성합니다. 예시로 /scraps/{scrapId} 라는 엔드포인트를 사용합니다.
        let baseURL = "http://52.78.37.90:8080"
        let urlString = "\(baseURL)/api/v1/scrap/\(scrapId)"

          
        guard let url = URL(string: "urlString") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"  // DELETE 메서드를 사용
        
        // URLSession을 통해 DELETE 요청을 보냅니다.
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error occurred: \(error)")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                // 성공적으로 삭제됨
                completion(true)
            } else {
                // 삭제 실패
                completion(false)
            }
        }
        
        task.resume()
    }

}


// 키워드 CollectionView 설정
extension ScrapDetailedViewController : UICollectionViewDelegate, UICollectionViewDataSource {
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
