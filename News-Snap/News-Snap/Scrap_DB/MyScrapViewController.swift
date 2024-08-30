import UIKit

class MyScrapViewController: UIViewController, UITextFieldDelegate {
    
    var scrapItems: [SearchNewsItemResult] = []


    // Outlet
    @IBOutlet weak var NewsTableView: UITableView!

    // Properties

    // Action
    @IBAction func SearchByCalenderTapped(_ sender: Any) {
        // Implement your search functionality here
    }

    @IBAction func MakeScrapTapped(_ sender: Any) {
        // Implement your scrap functionality here
    }

    @IBAction func BackButtonTapped(_ sender: Any) {
        // 스토리보드에서 TabBarController를 인스턴스화
        guard let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else {
            return
        }
        // 화면 전환 애니메이션 설정
        tabBarController.modalTransitionStyle = .coverVertical
        // 전환된 화면이 보여지는 방법 설정
        tabBarController.modalPresentationStyle = .fullScreen
        // 화면 전환 수행
        self.present(tabBarController, animated: true, completion: nil)
    }

    @IBAction func PageControl(_ sender: Any) {
        // Implement your page control functionality here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NewsTableView.delegate = self
        NewsTableView.dataSource = self
        NewsTableView.separatorStyle = .none // 클릭했을 때 자동 색상 변환 지우기

        // NIB 파일 등록
        let feedNib = UINib(nibName: "EachNewsTableViewCell", bundle: nil)
        NewsTableView.register(feedNib, forCellReuseIdentifier: "EachNewsTableViewCell")

        // API 요청
        fetchNewsData()
    }

    // API 요청 및 데이터 파싱
    private func fetchNewsData() {
        guard let url = URL(string: "http://52.78.37.90:8080/api/v1/scrap") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON: \(jsonString)")
            }

            do {
                let decoder = JSONDecoder()
                
                // JSON 응답을 APIResponse로 디코딩
                let apiResponse = try decoder.decode(APIScrapDataResponse.self, from: data)
                self.scrapItems = apiResponse.result // 배열 할당
                
                DispatchQueue.main.async {
                    self.NewsTableView.reloadData()
                }
            } catch {
                print("Error decoding data: \(error)")
            }


        }

        task.resume()
    }
}

extension MyScrapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scrapItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EachNewsTableViewCell", for: indexPath) as? EachNewsTableViewCell else {
            return UITableViewCell()
        }


        // `scrapList` 배열의 특정 요소에 접근
        let scrapItem = scrapItems[indexPath.row]

        // 각 필드에 접근하여 셀에 데이터 설정
        cell.NewsTitle.text = scrapItem.title
        cell.Keyword.text = scrapItem.keywords.joined(separator: ", ")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: scrapItem.updatedAt) {
            // 날짜를 원하는 형식으로 변환하여 UILabel에 설정
            let displayDateFormatter = DateFormatter()
            displayDateFormatter.dateStyle = .medium
            displayDateFormatter.timeStyle = .short
            cell.Date.text = displayDateFormatter.string(from: date)
        } else {
            cell.Date.text = "N/A" // 변환 실패 시 기본값
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 // TableViewCell 크기 강제 조정
    }
}
