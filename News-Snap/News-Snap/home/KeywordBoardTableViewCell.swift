//
//  KeywordBoardTableViewCell.swift
//  News-Snap
//
//  Created by 선가연 on 8/8/24.
//

import UIKit

class KeywordBoardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsImageView.layer.cornerRadius = 10
        newsImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
