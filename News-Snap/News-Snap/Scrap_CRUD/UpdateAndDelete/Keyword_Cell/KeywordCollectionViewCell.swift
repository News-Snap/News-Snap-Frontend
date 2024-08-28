//
//  keywordCollectionViewCell.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 8/27/24.
//

import UIKit

class KeywordCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var keywordCell: UIView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        keywordCell.layer.cornerRadius = 13.0 // 원하는 반경 값 설정
        keywordCell.layer.masksToBounds = true // 코너 반경 적용
    }

}
