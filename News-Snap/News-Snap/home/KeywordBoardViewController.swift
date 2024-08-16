//
//  KeywordBoardViewController.swift
//  News-Snap
//
//  Created by 선가연 on 8/8/24.
//

import UIKit

class KeywordBoardViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var keyword: String? // HomeViewController에서 전달된 키워드를 저장할 변수
    var scraps: [Scrap] = [] // 스크랩 데이터를 저장할 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
                
        // keywordBoardTableView 등록
        let keywordBoardNib = UINib(nibName: "KeywordBoardTableViewCell", bundle: nil)
        tableView.register(keywordBoardNib, forCellReuseIdentifier: "KeywordBoardTableViewCell")

        keywordLabel.text = "\"\(keyword ?? "")\" 키워드 보드"
        loadScrapsForKeyword(keyword)
    }
    
    private func loadScrapsForKeyword(_ keyword: String?) {
        guard let keyword = keyword else { return }
        
        // API 엔드포인트 URL 생성
        let urlString = "https://api.yourservice.com/scraps?keyword=\(keyword)"
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            print("Invalid URL")
            return
        }
        
        // GET 요청
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
            
            // JSON 파싱 및 스크랩 데이터 저장
            do {
                let decodedScraps = try JSONDecoder().decode([Scrap].self, from: data)
                DispatchQueue.main.async {
                    self.scraps = decodedScraps
                    self.tableView.reloadData()
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
        
        // 네트워크 요청 시작
        task.resume()
    }
}

extension KeywordBoardViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scraps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "KeywordBoardTableViewCell", for: indexPath) as? KeywordBoardTableViewCell
        else {
            return UITableViewCell()
        }
        
        let scrap = scraps[indexPath.row]
        cell.newsTitleLabel.text = scrap.title
        cell.newsDateLabel.text = scrap.content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 270
    }
    
}
