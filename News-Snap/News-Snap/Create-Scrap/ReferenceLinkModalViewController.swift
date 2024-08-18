//
//  ReferenceLinkModalViewController.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 8/9/24.
//

import UIKit

protocol ReferenceLinkDelegate : AnyObject {
    func linkEntered(_ referenceLink : String)
}

protocol RefereceLinkCountDelegate : AnyObject {
    func referenceLinkCount(_ referenceLinkCount : Int)
}

class ReferenceLinkModalViewController: UIViewController {
    
    weak var delegate : ReferenceLinkDelegate?
    var referenceLink : String?
    
    weak var countDelegate : RefereceLinkCountDelegate?
    var referenceLinkCount : Int = 1
    
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
        guard let referenceLink = referenceLinkTextField.text else { return }
        delegate?.linkEntered(referenceLink)
        referenceLinkCount += 1
        countDelegate?.referenceLinkCount(referenceLinkCount)
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
