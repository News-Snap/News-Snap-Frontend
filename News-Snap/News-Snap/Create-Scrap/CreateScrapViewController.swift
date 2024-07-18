//
//  CreateScrapViewController.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 7/18/24.
//

import Foundation
import UIKit

class CreateScrapViewController : UIViewController {
    var scrap : Scrap!
    
    @IBOutlet weak var scrapContentTextField: UITextField!
    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var articleLinkTextField: UITextField!
    
    @IBAction func closeButton(_ sender: Any) {
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let keywordsText = keywordTextField.text,
              let articleLink = articleLinkTextField.text,
              let contents = scrapContentTextField.text else {
            // Handle the case where the text fields are not filled
            return
        }
                
        let keywords = keywordsText.components(separatedBy: "#").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        
        let id = generateID()
        
        scrap = Scrap(id: id, link: articleLink, contents: contents, keywords: keywords)
    }
    

    @IBAction func saveAttachmentFileButton(_ sender: Any) {
        scrap.attachmentFile = FileManager.default
    }
    
    
    @IBAction func saveReferenceFileButton(_ sender: Any) {
        scrap.referenceFile = FileManager.default
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func generateID() -> Int {
        // Generate a unique ID for the Scrap object
        // This is a simple placeholder implementation
        return Int(Date().timeIntervalSince1970)
    }
}
