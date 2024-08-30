import UIKit

class MyScrapViewController: UIViewController, UITextFieldDelegate {

    // Outlet
    @IBOutlet weak var NewsTableView: UITableView!

    // Properties
    private var newsItems: [SearchNewsItemResult] = []

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

            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(APIScrapDataResponse.self, from: data)
                
                // API 응답에서 데이터 가져오기
                self.newsItems = apiResponse.result

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
        return newsItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EachNewsTableViewCell", for: indexPath) as? EachNewsTableViewCell else {
            return UITableViewCell()
        }

        let newsItem = newsItems[indexPath.row]
        cell.NewsTitle.text = newsItem.title
        cell.Keyword.text = newsItem.keywords.joined(separator: ", ")
        
        // 이미지 설정이 필요한 경우, 적절한 이미지 URL을 처리
        // cell.imageViewFeed.image = UIImage(named: "placeholder")

        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 // TableViewCell 크기 강제 조정
    }
}
