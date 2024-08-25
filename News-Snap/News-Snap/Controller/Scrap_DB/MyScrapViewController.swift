//
//  MyScrapViewController.swift
//  News-Snap
//
//  Created by 문정현 on 8/12/24.
//

import UIKit

class MyScrapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
      
            
            // Delegate와 DataSource 설정
            TableView.delegate = self
            TableView.dataSource = self

            // 커스텀 셀 등록
            let nib = UINib(nibName: "FirstCellTableViewCell", bundle: nil)
            TableView.register(nib, forCellReuseIdentifier: "FirstCellTableViewCell")
        }
        
        // UITableViewDataSource 메서드 구현
        
        // 섹션당 행(row)의 수를 반환합니다.
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 6 // 셀의 개수를 6개로 설정
        }

        // 각 셀에 대한 구성 방법을 정의합니다.
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCellTableViewCell", for: indexPath) as? FirstCellTableViewCell else {
                return UITableViewCell()
            }
            
            // 셀을 구성하기 위해 필요한 데이터 설정을 추가합니다.
            // 예를 들어, cell.titleLabel.text = "제목" 과 같은 코드로 셀의 내용을 채울 수 있습니다.
            
            return cell
        }

        // UITableViewDelegate 메서드 (필요 시 추가 구현)
        
        // 셀이 선택되었을 때의 동작을 정의합니다.
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // 셀 선택 시 동작 구현
        }
    }
