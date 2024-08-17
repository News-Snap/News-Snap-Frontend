//
//  ReferenceLinkModalViewController.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 8/9/24.
//

import UIKit

class ReferenceLinkModalViewController: UIViewController {
    @IBOutlet weak var referenceLinkTextField: UITextField!
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.backgroundColor = nil
        mainView.layer.cornerRadius = 25
        mainView.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
