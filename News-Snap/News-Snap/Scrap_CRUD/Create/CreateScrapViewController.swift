//
//  CreateScrapViewController.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 7/18/24.
//

import Foundation
import UIKit

class CreateScrapViewController : UIViewController , UITextFieldDelegate, ReferenceLinkDelegate, AttachmentFileDelegatge {
    func fileEntered(_ fileLink: String) {
        self.fileLink = fileLink
    }
    
    func linkEntered(_ referenceLink: [String]) {
        self.referenceLinkListFinal = referenceLink
        referenceTableView.reloadData()
    }
    
    var scrap : Scrap!
    var referenceLink : String?
    var referenceLinkListFinal : [String] = [] 
    var fileLink : String?
    var attachmentFileCount : Int = 1
    var refereceLinkCount : Int = 1
    var keywords : [String] = []
    
    
    
    @IBOutlet weak var scrapContentTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var articleLinkTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var attachmentFileTableView: UITableView!
    @IBOutlet weak var referenceTableView: UITableView!
    
    @IBOutlet weak var keywordButton: UIButton!

    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text,
              let articleLink = articleLinkTextField.text,
              let contents = scrapContentTextField.text else {
            return
        }
                                
        scrap = Scrap(title: title, link: articleLink, contents: contents, keywords: keywords, date: Date(), attachmentFile: fileLink ?? "null", referenceLink: referenceLinkListFinal)
        
        print("Scrap saved:", scrap!)
        
        // API 통신 - POST 요청
         sendScrapDataToServer(scrap)
    }

    @IBAction func saveAttachmentFileButtonTapped(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AttachmentFileModalVC") as? AttachmentFileModalViewController else { return }
        
        nextVC.delegate = self
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
    @IBAction func saveReferenceLinkButtonTapped(_ sender: Any) {
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ReferenceLinkModalVC") as? ReferenceLinkModalViewController else { return }
        
        nextVC.delegate = self
        nextVC.referenceLinkList = referenceLinkListFinal
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scrapContentTextField.delegate = self
        titleTextField.delegate = self
        articleLinkTextField.delegate = self
            
        
        // 초기 상태에서 저장 버튼을 비활성화
        saveButton.isEnabled = false
        saveButton.setTitleColor(UIColor.red, for: .normal)
        
        // 첨부파일 관련
        attachmentFileTableView.delegate = self
        attachmentFileTableView.dataSource = self
        let attachmentFileNib = UINib(nibName: "AttachmentFileTableViewCell", bundle: nil)
        attachmentFileTableView.register(attachmentFileNib, forCellReuseIdentifier: "AttachmentFileTableViewCell")
        attachmentFileTableView.layer.cornerRadius = 8.0
        attachmentFileTableView.layer.masksToBounds = true
        
        // 참고자료 관련
        referenceTableView.delegate = self
        referenceTableView.dataSource = self
        let referenceNib = UINib(nibName: "ReferenceLinklTableViewCell", bundle: nil)
        referenceTableView.register(referenceNib, forCellReuseIdentifier: "ReferenceLinklTableViewCell")
        
        referenceTableView.layer.cornerRadius = 8.0
        referenceTableView.layer.masksToBounds = true
        
        keywordFunc()
    }
    
    
    // MARK: - Functions
    func keywordFunc() {
        let INTEREST_RATE = UIAction(title: "금리", handler: { [weak self] _ in
            self?.addKeyword("INTEREST_RATE")
        })
        let BIG_TECH = UIAction(title: "빅테크", handler: { [weak self] _ in
            self?.addKeyword("BIG_TECH")
        })
        let STARTUP = UIAction(title: "스타트업", handler: { [weak self] _ in
            self?.addKeyword("STARTUP")
        })
//        let INTERNATIONAL_EXCHANGE_RATE = UIAction(title: "국제 환율", handler: { [weak self] _ in
//            self?.addKeyword("INTERNATIONAL_EXCHANGE_RATE")
//        })
        let BLOCK_CHAIN = UIAction(title: "블록체인", handler: { [weak self] _ in
            self?.addKeyword("BLOCK_CHAIN")
        })
        let FINANCE = UIAction(title: "금융", handler: { [weak self] _ in
            self?.addKeyword("FINANCE")
        })
        let CERTIFICATE = UIAction(title: "증권", handler: { [weak self] _ in
            self?.addKeyword("CERTIFICATE")
        })
        let ECONOMIC_POLICY = UIAction(title: "경제정책", handler: { [weak self] _ in
            self?.addKeyword("ECONOMIC_POLICY")
        })
        let DOMESTIC = UIAction(title: "국내", handler: { [weak self] _ in
            self?.addKeyword("DOMESTIC")
        })
        let GLOBAL = UIAction(title: "국제", handler: { [weak self] _ in
            self?.addKeyword("GLOBAL")
        })
        let REAL_ESTATE = UIAction(title: "부동산", handler: { [weak self] _ in
            self?.addKeyword("REAL_ESTATE")
        })
        let SEMICONDUCTOR = UIAction(title: "반도체", handler: { [weak self] _ in
            self?.addKeyword("SEMICONDUCTOR")
        })
        let AUTOMOBILE = UIAction(title: "자동차", handler: { [weak self] _ in
            self?.addKeyword("AUTOMOBILE")
        })
        let FOOD = UIAction(title: "식료품", handler: { [weak self] _ in
            self?.addKeyword("FOOD")
        })
        let CONSTRUCTION = UIAction(title: "건설", handler: { [weak self] _ in
            self?.addKeyword("CONSTRUCTION")
        })
        
        let menu = UIMenu(title: "", children: [INTEREST_RATE, BIG_TECH, STARTUP, BLOCK_CHAIN, FINANCE, CERTIFICATE, ECONOMIC_POLICY, DOMESTIC, GLOBAL, REAL_ESTATE, SEMICONDUCTOR, AUTOMOBILE, FOOD, CONSTRUCTION])
        keywordButton.menu = menu
    }

    
    private func addKeyword(_ keyword: String) {
        if !keywords.contains(keyword) {
            keywords.append(keyword)
            print("Added keyword: \(keyword)")
        } else {
            print("\(keyword) is already added.")
        }
        print("Current keywords: \(keywords)")
    }
    
//    private func generateID() -> Int {
//        return Int(Date().timeIntervalSince1970)
//    }
    
    
    // 텍스트 필드 변경 감지
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.async {
            self.validateTextFields()
        }
        return true
    }
    
    // 키워드, 기사 링크, 요약 내용이 추가 되었는지 감지
    private func validateTextFields() {
        let keywordsText = titleTextField.text ?? ""
        let articleLink = articleLinkTextField.text ?? ""
        let contents = scrapContentTextField.text ?? ""

        let isFormValid = !keywordsText.isEmpty && !articleLink.isEmpty && !contents.isEmpty
        
        saveButton.isEnabled = isFormValid
        saveButton.setTitleColor(isFormValid ? UIColor.systemBlue : UIColor.lightGray, for: .normal)
    }
    
    private func sendScrapDataToServer(_ scrap: Scrap) {
        guard let url = URL(string: "http://52.78.37.90:8080/api/v1/scrap") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // 날짜를 "YYYY-MM-DD" 형식으로 변환하는 DateFormatter 설정
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // 날짜를 변환된 형식으로 변환
        let formattedDate = dateFormatter.string(from: scrap.date)
        
        // let temp : [String] = ["1"]
        // JSON 데이터로 변환
        let scrapData: [String: Any] = [
            "title": scrap.title,
            "keywords": scrap.keywords,
            "articleUrl": scrap.link,
            "articleCreatedAt": formattedDate, // ISO8601 형식으로 변환된 날짜
            "content": scrap.contents,
            "relatedUrlList": scrap.referenceLink // URL을 문자열로 변환
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: scrapData, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Serialized JSON:", jsonString)
            }
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            print("Failed to serialize data:", error)
            return
        }

        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error:", error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code:", httpResponse.statusCode)
                if !(200...299).contains(httpResponse.statusCode) {
                    print("Invalid response")
                    if let data = data,
                       let responseString = String(data: data, encoding: .utf8) {
                        print("Response data:", responseString)
                    }
                    return
                }
            }
            
            if let data = data {
                // JSON 데이터로 파싱
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    // 메인 스레드에서 UI 업데이트
                    DispatchQueue.main.async {
                        // UI 업데이트 코드를 여기에 작성
                        print("Response JSON:", jsonResponse)
                        // 예: self.updateUI(with: jsonResponse)
                    }
                } catch {
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Response data:", responseString)
                    } else {
                        print("Unable to parse response data")
                    }
                }
            }
        }
        task.resume()
    }
}

extension CreateScrapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1 {
            return 44
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return attachmentFileCount
        } else {
            return referenceLinkListFinal.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AttachmentFileTableViewCell", for: indexPath) as! AttachmentFileTableViewCell
            return cell
        } else if tableView.tag == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReferenceLinklTableViewCell", for: indexPath) as! ReferenceLinklTableViewCell
            cell.textLabel?.text = referenceLinkListFinal[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 10 // 섹션 푸터의 높이
//    }
    
    
}
