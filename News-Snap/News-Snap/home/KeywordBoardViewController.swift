//
//  KeywordBoardViewController.swift
//  News-Snap
//
//  Created by 선가연 on 8/8/24.
//

import UIKit

class KeywordBoardViewController: UIViewController {
    
    var selectedKeyword: String?
    var scraps: [Scrap] = []

    let token = ""
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
                
        // keywordBoardTableView 등록
        let keywordBoardNib = UINib(nibName: "KeywordBoardTableViewCell", bundle: nil)
        tableView.register(keywordBoardNib, forCellReuseIdentifier: "KeywordBoardTableViewCell")
        
        // 선택한 키워드로 초기화
        if let keyword = selectedKeyword {
            print("Selected keyword: \(keyword)")
            keywordLabel.text = "\"\(keyword)\""
            
            fetchData(for: keyword)
        }
    }
    
    @IBAction func dissmissDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func fetchData(for keyword: String) {
        let urlString = "http://52.78.37.90:8080/api/v1/scrap?keyword=\(keyword)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                print("Error fetching data: \(String(describing: error))")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(ScrapsResponse.self, from: data)
                print(decodedResponse)
                
                self.scraps = decodedResponse.result
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        
        task.resume()
    }
    
    @IBAction func backBtnDidtap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
        
        // 뉴스 제목 설정
        cell.newsTitleLabel.text = scrap.title
        
        // 날짜 형식 설정
        if let dateString = scrap.updatedAt {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "yyyy-MM-dd"
                cell.newsDataLabel.text = dateFormatter.string(from: date)
            } else {
                cell.newsDataLabel.text = "날짜 형식 오류"
            }
        } else {
            cell.newsDataLabel.text = "날짜 없음"
        }
        
        // 이미지 설정
        if let imageUrlString = scrap.attachmentFile, let imageUrl = URL(string: imageUrlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.newsImageView.image = image
                    }
                }
            }
        } else {
            cell.newsImageView.image = UIImage(named: "placeholder")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 270
    }
    
}
