//
//  RegisterViewController.swift
//  News-Snap
//  Created by 문정현 on 7/17/24.
//  Created by 문정현 on 8/9/24.
//


import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var BirthdayTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var PasswordConfirmTextField: UITextField!
    
    private var isPasswordVisible = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSigninButton()
        PasswordTextField.isSecureTextEntry = true
        PasswordConfirmTextField.isSecureTextEntry = true
        
        // 비밀번호 강력 보완 끄기
        PasswordTextField.textContentType = .oneTimeCode
        PasswordConfirmTextField.textContentType = .oneTimeCode
        
        // 서버 응답 오류: 텍필에서 보내는 데이터 문제
        EmailTextField.autocorrectionType = .no
        EmailTextField.autocapitalizationType = .none
        PasswordTextField.autocorrectionType = .no
        PasswordConfirmTextField.autocorrectionType = .no
        EmailTextField.autocorrectionType = .no
        EmailTextField.autocapitalizationType = .none
        PasswordTextField.autocorrectionType = .no
        PasswordConfirmTextField.autocorrectionType = .no
        
        // 이모지 입력 비활성화
        NameTextField.keyboardType = .default
        EmailTextField.keyboardType = .emailAddress
        BirthdayTextField.keyboardType = .numberPad
        PasswordTextField.keyboardType = .default
        PasswordConfirmTextField.keyboardType = .default

        
        // 키보드 쪽 Delegate 설정
        NameTextField.delegate = self
        EmailTextField.delegate = self
        BirthdayTextField.delegate = self
        PasswordTextField.delegate = self
        PasswordConfirmTextField.delegate = self
        
        // 키보드가 나타나고 사라지는 알림 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    // 키보드가 나타날 때 호출되는 메서드
       @objc func keyboardWillShow(notification: NSNotification) {
           // 키보드가 나타날 때의 동작을 정의 (필요에 따라 사용)
           print("키보드가 나타났습니다.")
       }
       
       // 키보드가 사라질 때 호출되는 메서드
       @objc func keyboardWillHide(notification: NSNotification) {
           // 키보드가 사라질 때의 동작을 정의 (필요에 따라 사용)
           print("키보드가 사라졌습니다.")
       }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 키보드 알림 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        
    // MARK: Action & Outlet //
    // 회원가입 버튼을 누를시 EmailVerificationViewController로 이동_8/8/목 Error 수정 실패 -> API 필요
    @IBAction func SigninButtonTapped(_ sender: Any) {
        // 입력 데이터 유효성 검사
        guard let name = NameTextField.text, !name.isEmpty else {
            showAlert(message: "이름을 입력해주세요.")
            return
        }
        
        guard let email = EmailTextField.text, isValidEmail(email) else {
            showAlert(message: "유효한 이메일을 입력해주세요.")
            return
        }
        
        guard let birthday = BirthdayTextField.text, isValidBirthday(birthday) else {
            showAlert(message: "생일은 YYYYMMDD 형식으로 8글자여야 합니다.")
            return
        }
        
        guard let password = PasswordTextField.text, isValidPassword(password) else {
            showAlert(message: "비밀번호 조건을 만족하게 다시 설정해주세요.")
            return
        }
        
        guard let passwordConfirm = PasswordConfirmTextField.text, password == passwordConfirm else {
            showAlert(message: "비밀번호가 일치하지 않습니다.")
            return
        }
        
        // 생일을 "YYYY-MM-DD" 형식으로 변환
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyyMMdd"
           
           if let date = dateFormatter.date(from: birthday) {
               dateFormatter.dateFormat = "yyyy-MM-dd"
               let formattedBirthday = dateFormatter.string(from: date)
               
               // 입력된 데이터를 콘솔에 출력
               print("Name: \(name)")
               print("Email: \(email)")
               print("Birthday: \(formattedBirthday)")
               print("Password: \(password)")
               print("Password Confirm: \(passwordConfirm)")
               
               // 서버에 데이터 전송
               registerUser(name: name, email: email, birthday: formattedBirthday, password: password)
           } else {
               showAlert(message: "유효한 생일을 입력해주세요.")
           }
       }
    
    
    
    
    @IBOutlet weak var SigninButton: UIButton!
    
    
    
    @IBAction func BackButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
        
    }
    
    
    @IBAction func InvisibleButtonTapped(_ sender: Any) {
        
        // 비밀번호를 **로 암호화하게 해주는 디테일 설정 코드
        isPasswordVisible.toggle()
        // 비밀번호를 암호화해주는 코드(인스펙터 영역에서 secure text entry 으로 설정할 수도 있음)
        PasswordTextField.isSecureTextEntry = !isPasswordVisible
        
        
        
    }
    
    
    @IBAction func SecondInvisibleButtonTapped(_ sender: Any) {
        isPasswordVisible.toggle()
        PasswordConfirmTextField.isSecureTextEntry = !isPasswordVisible
        
    }
    
    
    
    // MARK: Func //
    // 유효성 검사 기준 코드
    private func configureSigninButton() {
        SigninButton.layer.cornerRadius = 10.0
        SigninButton.clipsToBounds = true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidBirthday(_ birthday: String) -> Bool {
        return birthday.count == 8 && Int(birthday) != nil
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[!@#$&*])(?=.*[A-Za-z])(?=.*[0-9]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPredicate.evaluate(with: password)
    }
    
    
// MARK: -----------------------------------------------------------------------------------------------------------------------------------------------------------------
    // API쪽 새로운 코드
       private func registerUser(name: String, email: String, birthday: String, password: String) {
           guard let url = URL(string: "http://52.78.37.90:8080/api/v1/auth/signup") else {
               showAlert(message: "잘못된 서버 주소입니다.")
               return
           }
           
           let parameters: [String: Any] = [
               "email": email,
               "nickname": name,
               "password": password,
               "birthDate": birthday,
               "pushAlarm": true // 기본 값 또는 사용자 설정 값
           ]
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
           do {
               request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
           } catch {
               showAlert(message: "데이터 전송 오류")
               return
           }
           
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               DispatchQueue.main.async {
                   if let error = error {
                       self.showAlert(message: "서버 오류: \(error.localizedDescription)")
                       return
                   }
                   
                   guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                       if let httpResponse = response as? HTTPURLResponse {
                           print("서버 응답 코드: \(httpResponse.statusCode)")
                       }
                       self.showAlert(message: "서버 응답 오류")
                       return
                   }
                   
                   self.showAlert(message: "회원가입이 완료되었습니다!")
                   
                   guard let emailVerificationVC = self.storyboard?.instantiateViewController(withIdentifier: "EmailVerificationVC") as? EmailVerificationViewController else {
                       print("Error: Unable to instantiate view controller with identifier 'EmailVerificationVC'")
                       return
                   }
                   
                   emailVerificationVC.modalTransitionStyle = .coverVertical
                   emailVerificationVC.modalPresentationStyle = .fullScreen
                   self.present(emailVerificationVC, animated: true, completion: nil)
               }
           }
           task.resume()
       }
// MARK: ------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
       private func showAlert(message: String) {
           let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
       
       // UITextFieldDelegate 메서드 추가
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }
   }
