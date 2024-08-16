//
//  ReferenceLinklTableViewCell.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 8/8/24.
//

import UIKit

class ReferenceLinklTableViewCell: UITableViewCell , ReferenceLinkDelegate {
    
    func linkEntered(_ referenceLink: String) {
        self.referenceLink = referenceLink
    }
    
    
    @IBOutlet weak var referenceLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    var referenceLink : String!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.backgroundColor = UIColor(red: 140/255, green: 217/255, blue: 233/255, alpha: 1)
        mainView.layer.cornerRadius = 0.4
        mainView.layer.masksToBounds = true
        // referenceLabel.text = referenceLink
        
//        NSLayoutConstraint.activate([
//            mainView.heightAnchor.constraint(equalToConstant: 48),
//            mainView.widthAnchor.constraint(equalToConstant: 383)
//        ])
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
