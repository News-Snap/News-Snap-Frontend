//
//  AttachmentFileModalViewController.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 8/8/24.
//

import UIKit

protocol AttachmentFileDelegatge : AnyObject {
    func fileEntered(_ fileLink : String)
}

class AttachmentFileModalViewController: UIViewController {
    
    
    weak var delegate : AttachmentFileDelegatge?
    var fileLink : String?
    
    @IBOutlet var RootView: UIView!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var linkTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        RootView.backgroundColor = nil
        MainView.layer.cornerRadius = 25
        MainView.layer.masksToBounds = true


        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        guard let fileLink = linkTextField.text else { return }
        delegate?.fileEntered(fileLink)
        self.dismiss(animated: true, completion: nil)
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
