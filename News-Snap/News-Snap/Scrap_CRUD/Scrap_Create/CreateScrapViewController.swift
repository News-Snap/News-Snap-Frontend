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
    
    func linkEntered(_ referenceLink: String) {
        self.referenceLink = referenceLink
        
    }
    
    func attachmentFileCount(_ attachmentFileCount : Int){
        self.attachmentFileCount = attachmentFileCount
    }
    
    func referenceLinkCount(_ referenceLinkCount : Int){
        self.refereceLinkCount = referenceLinkCount
        
    }

    
    var scrap : Scrap!
    var referenceLink : String?
    var fileLink : String?
    var attachmentFileCount : Int = 1
    var refereceLinkCount : Int = 1
    
    
    
    @IBOutlet weak var scrapContentTextField: UITextField!
    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var articleLinkTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var attachmentFileTableView: UITableView!
    @IBOutlet weak var referenceTableView: UITableView!
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let keywordsText = keywordTextField.text,
              let articleLink = articleLinkTextField.text,
              let contents = scrapContentTextField.text else {
            return
        }
                
        let keywords = keywordsText.components(separatedBy: "#").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        
        let id = generateID()
        
        scrap = Scrap(id: id, link: articleLink, contents: contents, keywords: keywords, date: Date(), attachmentFile: fileLink ?? "null", referenceLink: referenceLink ?? "null")
        
        print("Scrap saved:", scrap!)
        
        // API 통신 - POST 요청
         sendScrapDataToServer(scrap)
    }

    @IBAction func saveAttachmentFileButtonTapped(_ sender: Any) {
//        guard let scrap = scrap else {
//            print("초기화 필요")
//            return
//        }
//        
//        // 예제 URL 사용, 실제 파일을 선택하고 URL을 지정해야 함
//        // scrap.attachmentFile = URL(fileURLWithPath: "path/to/attachment/file")
//        
//        print("Attachment file saved:", scrap.attachmentFile ?? "None")
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AttachmentFileModalVC") as? AttachmentFileModalViewController else { return }
        
        nextVC.delegate = self
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
    @IBAction func saveReferenceLinkButtonTapped(_ sender: Any) {
//        guard let scrap = scrap else {
//            print("Scrap is not initialized.")
//            return
//        }
        // 예제 URL 사용, 실제 파일을 선택하고 URL을 지정해야 함
        // scrap.referenceFile = URL(fileURLWithPath: "path/to/reference/file")
//        print("Reference file saved:", scrap.referenceFile ?? "None")
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ReferenceLinkModalVC") as? ReferenceLinkModalViewController else { return }
        
        nextVC.delegate = self
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scrapContentTextField.delegate = self
        keywordTextField.delegate = self
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
        
        
    }
    
    private func generateID() -> Int {
        return Int(Date().timeIntervalSince1970)
    }
    
    
    // 텍스트 필드 변경 감지
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.async {
            self.validateTextFields()
        }
        return true
    }
    
    // 키워드, 기사 링크, 요약 내용이 추가 되었는지 감지
    private func validateTextFields() {
        let keywordsText = keywordTextField.text ?? ""
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
        
        let temp : [String] = ["1"]
        // JSON 데이터로 변환
        let scrapData: [String: Any] = [
            "title": "scrap.id",
            "articleUrl": scrap.link,
            "content": scrap.contents,
            "keywords": scrap.keywords,
            "articleCreatedAt": ISO8601DateFormatter().string(from: scrap.date), // ISO8601 형식으로 변환된 날짜
            "relatedUrlList": temp // URL을 문자열로 변환
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: scrapData, options: [])
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
                }
            }

            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response data:", responseString)
                } else {
                    print("Unable to parse response data")
                }
            }
        }
        task.resume()
    }

}

extension CreateScrapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return attachmentFileCount
        } else {
            return refereceLinkCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AttachmentFileTableViewCell", for: indexPath) as! AttachmentFileTableViewCell
            return cell
        } else if tableView.tag == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReferenceLinklTableViewCell", for: indexPath) as! ReferenceLinklTableViewCell
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
