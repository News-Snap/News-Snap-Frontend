//
//  ContentsViewController.swift
//  News-Snap
//
//  Created by 선가연 on 8/17/24.
//

import UIKit

class ContentsViewController: UIViewController {

    
    @IBOutlet weak var keywordsStackView: UIStackView!
    
    var keywords: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchKeywords { [weak self] fetchedKeywords in
            self?.keywords = fetchedKeywords
            DispatchQueue.main.async {
                self?.setupKeywordButtons()
            }
        }
    }
    
    private func fetchKeywords(completion: @escaping ([String]) -> Void) {
        let urlString = "http://52.78.37.90:8080/api/v1/news/popular-keywords"
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            completion([])
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching keywords: \(error)")
                completion([])
                return
            }

            guard let data = data else {
                print("No data received")
                completion([])
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(PopularStocksResponse.self, from: data)
                let stocks = decodedResponse.result.popularStocks.map { $0.stock }
                completion(stocks)
            } catch {
                print("Error decoding keywords: \(error)")
                completion([])
            }
        }

        task.resume()
    }

    private func setupKeywordButtons() {
            var currentStackView: UIStackView?
            
            for keyword in keywords {
                let button = createKeywordButton(with: keyword)
                
//                if currentStackView == nil || !canFitButtonInStackView(button, stackView: currentStackView!) {
//                    // 새로운 수평 스택 뷰 생성
//                    currentStackView = UIStackView()
//                    currentStackView?.axis = .horizontal
//                    currentStackView?.spacing = 10
//                    currentStackView?.alignment = .fill
//                    keywordsStackView.addArrangedSubview(currentStackView!)
//                }
                
                //currentStackView?.addArrangedSubview(button)
            }
        }
        
        private func createKeywordButton(with title: String) -> UIButton {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.backgroundColor = UIColor.systemGray6
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 15
            button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
            button.sizeToFit()
            return button
        }
        
        private func canFitButtonInStackView(_ button: UIButton, stackView: UIStackView) -> Bool {
            let totalWidth = stackView.arrangedSubviews.reduce(0) { $0 + $1.frame.width } + button.frame.width + stackView.spacing * CGFloat(stackView.arrangedSubviews.count)
            return totalWidth <= stackView.frame.width
        }

}
