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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
                
        // keywordBoardTableView 등록
        let keywordBoardNib = UINib(nibName: "KeywordBoardTableViewCell", bundle: nil)
        tableView.register(keywordBoardNib, forCellReuseIdentifier: "KeywordBoardTableViewCell")

    }
}

extension KeywordBoardViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "KeywordBoardTableViewCell", for: indexPath) as? KeywordBoardTableViewCell
        else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 270
    }
    
}
