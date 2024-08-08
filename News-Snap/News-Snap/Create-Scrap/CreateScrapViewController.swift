//
//  CreateScrapViewController.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 7/18/24.
//

import Foundation
import UIKit

class CreateScrapViewController : UIViewController , UITextFieldDelegate {
    
    var scrap : Scrap!
    
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
        
        scrap = Scrap(id: id, link: articleLink, contents: contents, keywords: keywords, date: Date())
        print("Scrap saved:", scrap!)
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
        
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
    @IBAction func saveReferenceLinkButtonTapped(_ sender: Any) {
        guard let scrap = scrap else {
            print("Scrap is not initialized.")
            return
        }
        // 예제 URL 사용, 실제 파일을 선택하고 URL을 지정해야 함
        // scrap.referenceFile = URL(fileURLWithPath: "path/to/reference/file")
        print("Reference file saved:", scrap.referenceFile ?? "None")
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
        referenceTableView.register(attachmentFileNib, forCellReuseIdentifier: "AttachmentFileTableViewCell")
        
        // 참고자료 관련
        referenceTableView.delegate = self
        referenceTableView.dataSource = self
        let referenceNib = UINib(nibName: "ReferenceTableViewCell", bundle: nil)
        referenceTableView.register(referenceNib, forCellReuseIdentifier: "ReferenceTableViewCell")
        

        
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
}

extension CreateScrapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == attachmentFileTableView {
          //  return cell
        } else if tableView == referenceTableView {
         //   return cell
        } else {
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == attachmentFileTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
            //cell.textLabel?.text = data1[indexPath.row]
            return cell
        } else if tableView == referenceTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
            //cell.textLabel?.text = data2[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}
