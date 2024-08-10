//
//  ScrapSearchByDateViewController.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 8/10/24.
//

import UIKit

class ScrapSearchByDateViewController: UIViewController {
    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Select a date"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var dateView: UICalendarView = {
        var view = UICalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.wantsDateDecorations = true
        return view
    }()
        
    var selectedDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(dateTextField)
        view.addSubview(dateView)
        
        NSLayoutConstraint.activate([
            dateTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateTextField.heightAnchor.constraint(equalToConstant: 40),
            
            dateView.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 300),
            dateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            dateView.widthAnchor.constraint(equalToConstant: 300),
            dateView.heightAnchor.constraint(equalToConstant: 400)
        ])
            
        dateView.delegate = self
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    



extension ScrapSearchByDateViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents = dateComponents,
              let selectedDate = Calendar.current.date(from: dateComponents) else {
            return
        }
        
        // 날짜를 저장
        self.selectedDate = selectedDate
        
        // 날짜를 텍스트 필드에 표시
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateTextField.text = dateFormatter.string(from: selectedDate)
    }
}
