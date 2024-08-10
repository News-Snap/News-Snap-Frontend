//
//  HomeViewController.swift
//  News-Snap
//
//  Created by 선가연 on 8/8/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var key1Btn: UIButton!
    @IBOutlet weak var key2Btn: UIButton!
    @IBOutlet weak var key3Btn: UIButton!
    @IBOutlet weak var key4Btn: UIButton!
    @IBOutlet weak var myScrapBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 키워드 버튼 둥글게
        key1Btn.layer.cornerRadius = key1Btn.frame.width / 2
        key1Btn.layer.masksToBounds = true
        key2Btn.layer.cornerRadius = key2Btn.frame.width / 2
        key2Btn.layer.masksToBounds = true
        key3Btn.layer.cornerRadius = key3Btn.frame.width / 2
        key3Btn.layer.masksToBounds = true
        key4Btn.layer.cornerRadius = key4Btn.frame.width / 2
        key4Btn.layer.masksToBounds = true
        
        // 나의 기사 스크랩 버튼 둥글게
        myScrapBtn.layer.cornerRadius = 10
        myScrapBtn.layer.masksToBounds = true
    }
    
    @IBAction func key1DidTap(_ sender: UIButton) {
    }
    
    @IBAction func key2DidTap(_ sender: UIButton) {
    }
    
    @IBAction func key3DidTap(_ sender: UIButton) {
    }
    
    @IBAction func key4DidTap(_ sender: UIButton) {
    }
    
    @IBAction func myScrapDidTap(_ sender: UIButton) {
    }
    
}
