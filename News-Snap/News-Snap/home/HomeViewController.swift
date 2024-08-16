//
//  HomeViewController.swift
//  News-Snap
//
//  Created by 선가연 on 8/8/24.
//

import UIKit

class HomeViewController: UIViewController {
    var scrap : Scrap!
    var selectedKeyword: String?
    
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
        
        // API 통신 - GET 요청
        getKeywordScrap()
    }
    
    private func getKeywordScrap() {
        let urlString = APIConstants.fetureURL
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // URLSession을 사용하여 GET 요청
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // 에러 처리
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
                    
            // 데이터 유효성 확인
            guard let data = data else {
                print("No data received")
                return
            }
                
            // JSON 파싱
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    // JSON 데이터에서 키워드 추출
                    let keywords = jsonArray.compactMap { $0["keyword"] as? String }
                        
                    DispatchQueue.main.async {
                        if keywords.count > 0 {
                            self.key1Btn.setTitle(keywords[0], for: .normal)
                        }
                        if keywords.count > 1 {
                            self.key2Btn.setTitle(keywords[1], for: .normal)
                        }
                        if keywords.count > 2 {
                            self.key3Btn.setTitle(keywords[2], for: .normal)
                        }
                        if keywords.count > 3 {
                            self.key4Btn.setTitle(keywords[3], for: .normal)
                        }
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
            
        // 네트워크 요청 시작
        task.resume()
    }
    
    
    // Actions
    @IBAction func key1DidTap(_ sender: UIButton) {
        selectedKeyword = key1Btn.titleLabel?.text
        performSegue(withIdentifier: "showKeywordBoard", sender: self)
    }
    
    @IBAction func key2DidTap(_ sender: UIButton) {
        selectedKeyword = key2Btn.titleLabel?.text
        performSegue(withIdentifier: "showKeywordBoard", sender: self)
    }
    
    @IBAction func key3DidTap(_ sender: UIButton) {
        selectedKeyword = key3Btn.titleLabel?.text
        performSegue(withIdentifier: "showKeywordBoard", sender: self)
    }
    
    @IBAction func key4DidTap(_ sender: UIButton) {
        selectedKeyword = key4Btn.titleLabel?.text
        performSegue(withIdentifier: "showKeywordBoard", sender: self)
    }
    
    @IBAction func myScrapDidTap(_ sender: UIButton) {
        // 스크랩 조회 페이지로 이동
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showKeywordBoard" {
            if let destinationVC = segue.destination as? KeywordBoardViewController {
                destinationVC.keyword = selectedKeyword
            }
        }
    }
    
}
