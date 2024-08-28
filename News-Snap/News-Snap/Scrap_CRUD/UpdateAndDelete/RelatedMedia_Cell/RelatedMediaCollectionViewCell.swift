//
//  RelatedMediaCollectionViewCell.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 8/28/24.
//

import UIKit

class RelatedMediaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        mainView.layer.cornerRadius = 10.0
        mainView.layer.masksToBounds = true
        mainView.backgroundColor = UIColor.black
        super.awakeFromNib()
        // Initialization code
    }

}
