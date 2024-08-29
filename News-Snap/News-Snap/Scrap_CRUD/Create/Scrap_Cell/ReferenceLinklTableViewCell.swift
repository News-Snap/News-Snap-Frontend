//
//  ReferenceLinklTableViewCell.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 8/8/24.
//

import UIKit

class ReferenceLinklTableViewCell: UITableViewCell {
    
    @IBOutlet weak var referenceLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.layer.borderWidth = 0.8 // 보더 두께 설정
        mainView.layer.cornerRadius = 8.0 // 원하는 반경 값 설정
        mainView.layer.masksToBounds = true // 코너 반경 적용
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        // 테이블 뷰 셀 사이의 간격
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0))
    }
    
}
