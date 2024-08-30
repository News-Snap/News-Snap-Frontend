//
//  ContentTableViewCell.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 8/28/24.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    @IBOutlet weak var contentLabel: UILabel!
    
    // Configure 메서드 추가
    func configure(with content: String) {
        contentLabel.text = content
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
