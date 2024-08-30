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
    
    let keywordTranslations: [String: String] = [
        "INTEREST_RATE": "금리",
        "BIG_TECH": "빅테크",
        "STARTUP": "스타트업",
        "BLOCK_CHAIN": "블록체인",
        "FINANCE": "금융",
        "CERTIFICATE": "증권",
        "ECONOMIC_POLICY": "경제정책",
        "DOMESTIC": "국내",
        "GLOBAL": "국제",
        "REAL_ESTATE": "부동산",
        "SEMICONDUCTOR": "반도체",
        "AUTOMOBILE": "자동차",
        "FOOD": "식료품",
        "CONSTRUCTION": "건설"
    ]

    
    var scrap : Scrap?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteButton()
        fetchScrapData()
        
        // 키워드 생성
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
        let keywordNib = UINib(nibName: "KeywordCollectionViewCell", bundle: nil)
        keywordCollectionView.register(keywordNib, forCellWithReuseIdentifier: "KeywordCollectionViewCell")
        // Layout invalidation
        keywordCollectionView.collectionViewLayout.invalidateLayout()

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
    func updateCollectionViewLayout() {
        keywordCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func setupUI(with scrap: Scrap) {
        // UI 요소에 Scrap 모델 데이터 바인딩
        articleTitle.text = scrap.title
        
        // Date를 문자열로 변환하여 표시
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        articleDate.text = dateFormatter.string(from: scrap.date)
        
        // Keywords와 관련된 UI 업데이트
        keywordCollectionView.reloadData()
        
        // 첨부파일이 있을 경우 버튼에 파일명 설정
        if !scrap.attachmentFile.isEmpty {
            attachmentFile.setTitle(scrap.attachmentFile, for: .normal)
        } else {
            attachmentFile.isHidden = true // 파일이 없으면 버튼 숨김
        }
        
        // 관련 미디어 CollectionView 업데이트
        relatedMediaCollectionView.reloadData()
    }
    
    // MARK: - API 호출
    func fetchScrapData() {
        guard let url = URL(string: "http://52.78.37.90:8080/api/v1/scrap/2") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            // 실제 JSON 응답을 출력
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON: \(jsonString)")
            }
            
            do {
                // JSONDecoder 설정
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 // ISO8601 형식으로 날짜 디코딩
                
                // JSON 데이터를 APIResponse로 디코딩
                let apiResponse = try decoder.decode(APIResponse.self, from: data)
                let result = apiResponse.result
                
                // Scrap 모델로 변환
                let scrap = Scrap(
                    title: result.title,
                    link: result.articleUrl,
                    contents: result.content,
                    keywords: result.keywords,
                    date: ISO8601DateFormatter().date(from: result.modifiedAt) ?? Date(),
                    attachmentFile: result.fileUrl ?? "",
                    referenceLink: result.relatedUrlList
                )
                
                // 메인 스레드에서 UI 업데이트
                DispatchQueue.main.async {
                    self.scrap = scrap
                    self.contentTableView.reloadData() // 데이터 새로고침
                    self.setupUI(with: scrap)
                }
                
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    
    func deleteButton() {
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
            
            self.deleteScrap(scrapId: "25", completion: { success in
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
        guard let url = URL(string: "http://52.78.37.90:8080/api/v1/scrap/25") else {
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
            return scrap?.keywords.count ?? 0
        }
        else {
            return 2
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView.tag == 0 {
//            // 셀의 너비와 높이를 계산합니다.
//            let maxWidth = collectionView.frame.width - 16 // 여백을 고려하여 최대 너비를 설정합니다.
//            let keyword = scrap?.keywords[indexPath.row] ?? ""
//            
//            // 텍스트의 크기를 계산하여 셀의 높이를 결정합니다.
//            let font = UIFont.systemFont(ofSize: 16) // 사용할 폰트와 크기
//            let textSize = (keyword as NSString).boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude),
//                                                              options: .usesLineFragmentOrigin,
//                                                              attributes: [NSAttributedString.Key.font: font],
//                                                              context: nil).size
//            
//            // 셀의 크기를 결정합니다.
//            let cellWidth = textSize.width + 16 // 패딩을 추가
//            let cellHeight = textSize.height + 16 // 패딩을 추가
//
//            return CGSize(width: cellWidth, height: cellHeight)
//        }
//        else {
//            return CGSize(width: 160, height: 153)
//        }
//        
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCollectionViewCell", for: indexPath) as? KeywordCollectionViewCell else {
                return UICollectionViewCell()
            }
            // 키워드 데이터 설정
            // 키워드 데이터 설정
            if let keyword = scrap?.keywords[indexPath.row] {
                let koreanKeyword = keywordTranslations[keyword] ?? keyword
                cell.configure(with: koreanKeyword)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            // 적절한 셀 사이즈 계산 로직 추가
            let keyword = scrap?.keywords[indexPath.row] ?? ""
            let label = UILabel()
            label.text = "#\(keyword)"
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            let size = label.sizeThatFits(CGSize(width: collectionView.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            return CGSize(width: size.width + 20, height: size.height + 20) // 여백 추가
        }
        else {
            return CGSize(width: 160, height: 153)
        }
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
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell", for: indexPath) as? ContentTableViewCell else {
            return UITableViewCell()
        }
        
        // 셀에 콘텐츠 설정
        if let content = scrap?.contents {
            cell.configure(with: content)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
