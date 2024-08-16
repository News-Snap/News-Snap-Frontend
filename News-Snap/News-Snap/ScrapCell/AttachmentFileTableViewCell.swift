//
//  AttachmentFileTableViewCell.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 8/8/24.
//

import UIKit



class AttachmentFileTableViewCell: UITableViewCell, AttachmentFileDelegatge {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var AttachmentFilePath: UILabel!
    var fileLink : String!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.backgroundColor = UIColor(red: 140/255, green: 217/255, blue: 233/255, alpha: 1)
        cellView.layer.cornerRadius = 0.4
        cellView.layer.masksToBounds = true
        // heightAnchor 제약 조건 설정
        cellView.translatesAutoresizingMaskIntoConstraints = false
        
//        NSLayoutConstraint.activate([
//            cellView.heightAnchor.constraint(equalToConstant: 48),
//            cellView.widthAnchor.constraint(equalToConstant: 383)
//        ])
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fileEntered(_ fileLink: String) {
        self.fileLink = fileLink
        AttachmentFilePath.text = fileLink
    }
}
