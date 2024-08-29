//
//  HomeViewController.swift
//  News-Snap
//
//  Created by 선가연 on 8/8/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var key1Btn: UIButton!
    @IBOutlet weak var key2Btn: UIButton!
    @IBOutlet weak var key3Btn: UIButton!
    @IBOutlet weak var key4Btn: UIButton!
    
    @IBOutlet weak var myScrapBtn: UIButton!
    
    @IBOutlet weak var news1View: UIView!
    @IBOutlet weak var news1TitleLabel: UILabel!
    @IBOutlet weak var news1ContentLabel: UILabel!
    @IBOutlet weak var news1ImageView: UIImageView!
    
    @IBOutlet weak var news2View: UIView!
    @IBOutlet weak var news2TitleLabel: UILabel!
    @IBOutlet weak var news2ContentLabel: UILabel!
    @IBOutlet weak var news2ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 키워드 버튼 둥글게
        key1Btn.layer.cornerRadius = key1Btn.frame.width / 2
        key1Btn.layer.masksToBounds = true
        key2Btn.layer.cornerRadius = key2Btn.frame.width / 2
        key2Btn.layer.masksToBounds = true
        key3Btn.layer.cornerRadius = key3Btn.frame.width / 2
        key3Btn.layer.masksToBounds = true
        key4Btn.layer.cornerRadius = key4Btn.frame.width / 2
        key4Btn.layer.masksToBounds = true
        
        // 나의 기사 스크랩 버튼 둥글게
        myScrapBtn.layer.cornerRadius = 10
        myScrapBtn.layer.masksToBounds = true
        
        // 뉴스
        news1View.layer.borderWidth = 1
        news1View.layer.borderColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0).cgColor
        news1View.layer.cornerRadius = 10
        news1View.layer.masksToBounds = true
        
        news2View.layer.borderWidth = 1
        news2View.layer.borderColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0).cgColor
        news2View.layer.cornerRadius = 10
        news2View.layer.masksToBounds = true
        
        // TOP 4 키워드 조회
        fetchKeywords { [weak self] keywords in
            DispatchQueue.main.async {
                self?.updateKeywordButtons(with: keywords)
            }
        }
        
    }
    
    func updateKeywordButtons(with keywords: [String]) {
        if keywords.count > 0 {
            key1Btn.setTitle(keywords[0], for: .normal)
        }
        if keywords.count > 1 {
            key2Btn.setTitle(keywords[1], for: .normal)
        }
        if keywords.count > 2 {
            key3Btn.setTitle(keywords[2], for: .normal)
        }
        if keywords.count > 3 {
            key4Btn.setTitle(keywords[3], for: .normal)
        }
    }
    
    // 키워드 버튼 클릭했을 시 동작
    @IBAction func key1DidTap(_ sender: UIButton) {
        guard let keyword = sender.titleLabel?.text else { return }
        navigateToKeywordBoard(with: keyword)
    }
    
    @IBAction func key2DidTap(_ sender: UIButton) {
        guard let keyword = sender.titleLabel?.text else { return }
        navigateToKeywordBoard(with: keyword)
    }
    
    @IBAction func key3DidTap(_ sender: UIButton) {
        guard let keyword = sender.titleLabel?.text else { return }
        navigateToKeywordBoard(with: keyword)
    }
    
    @IBAction func key4DidTap(_ sender: UIButton) {
        guard let keyword = sender.titleLabel?.text else { return }
        navigateToKeywordBoard(with: keyword)
    }
    
    @IBAction func myScrapDidTap(_ sender: UIButton) {
        guard let keyword = sender.titleLabel?.text else { return }
        navigateToKeywordBoard(with: keyword)
    }
    
    func navigateToKeywordBoard(with keyword: String) {
        // 스토리보드에서 `KeywordBoardViewController`를 가져옴
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let keywordBoardVC = storyboard.instantiateViewController(withIdentifier: "KeywordBoardViewController") as? KeywordBoardViewController {
            
            keywordBoardVC.selectedKeyword = keyword
            self.present(keywordBoardVC, animated: true, completion: nil)
        }
        
//        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "KeywordBoardViewController") as? KeywordBoardViewController else { return }
//        
//        // nextVC.delegate = self
//        nextVC.modalTransitionStyle = .coverVertical
//        nextVC.modalPresentationStyle = .overFullScreen
//        self.present(nextVC, animated: true, completion: nil)
    }
    
    // TOP 4 키워드 조회 GET 요청
    func fetchKeywords(completion: @escaping ([String]) -> Void) {
        let urlString = "http://52.78.37.90:8080/api/v1/scrap/keywords"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching keywords: \(String(describing: error))")
                completion([])
                return
            }
            
            do {
                let keywords = try JSONDecoder().decode([String].self, from: data)
                completion(keywords)
            } catch {
                print("Error decoding keywords: \(error)")
                completion([])
            }
        }
        
        task.resume()
    }
        
        //    func fetchScraps(for keyword: String) {
        //        let urlString = "https://yourserver.com/api/scraps?keyword=\(keyword)"
        //        guard let url = URL(string: urlString) else { return }
        //
        //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
        //            guard let data = data, error == nil else {
        //                print("Error fetching data: \(String(describing: error))")
        //                return
        //            }
        //
        //            do {
        //                let scraps = try JSONDecoder().decode([Scrap].self, from: data)
        //                DispatchQueue.main.async {
        //                    self.updateTableView(with: scraps)
        //                }
        //            } catch {
        //                print("Error decoding data: \(error)")
        //            }
        //        }
        //
        //        task.resume()
        //    }
}
