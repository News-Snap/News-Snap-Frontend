//
//  EachNewsTableViewCell.swift
//  News-Snap
//
//  Created by 문정현 on 8/26/24.
//

import UIKit

class EachNewsTableViewCell: UITableViewCell {
    
    
    // Outlet //
    @IBOutlet weak var NewsTitle: UILabel!
    @IBOutlet weak var Keyword: UILabel!
    @IBOutlet weak var Date: UILabel!
    
    
    // Action //
    @IBAction func ShareNewsTapped(_ sender: Any) {
    }
    @IBAction func GoToNewsTapped(_ sender: Any) {
    }
    // NewsTitle은 Label이라서 Action 연결 안됨, 그냥 GoToNewsTapped로만 이동하기
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
