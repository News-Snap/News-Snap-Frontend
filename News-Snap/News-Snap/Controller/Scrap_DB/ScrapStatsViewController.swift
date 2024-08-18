//
//  ScrapStatsViewController.swift
//  News-Snap
//
//  Created by 문정현 on 8/12/24.
//

import UIKit

class ScrapStatsViewController: UIViewController {

    // Outlet //
    
    
    
    // Action //
    @IBAction func BackToTabVarVCTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
                  self.view.window?.windowScene?.keyWindow?.rootViewController = vc
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

   
    
    
    

}
