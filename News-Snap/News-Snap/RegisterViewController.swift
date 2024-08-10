//
//  RegisterViewController.swift
//  News-Snap
//  Created by 문정현 on 7/17/24.
//  Created by 문정현 on 8/9/24.
//


import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var BirthdayTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var PasswordConfirmTextField: UITextField!
    
    private var isPasswordVisible = false // 새로운 코드입니다
    
    
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
            
            // 서버에 데이터 전송
            registerUser(name: name, email: email, birthday: birthday, password: password)
        }
    
    
    
    
    @IBOutlet weak var SigninButton: UIButton!
    
    
    
    @IBAction func BackButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
        
    }
    
    
    @IBAction func InvisibleButtonTapped(_ sender: Any) {
        
        // 비밀번호를 암호화해주는 코드(인스펙터 영역에서 secure text entry 으로 설정할 수도 있음)
        PasswordTextField.isSecureTextEntry = !isPasswordVisible
        // 비밀번호를 **로 암호화하게 해주는 디테일 설정 코드
        isPasswordVisible.toggle()

              
    }
    
    
    @IBAction func SecondInvisibleButtonTapped(_ sender: Any) {
        
        PasswordConfirmTextField.isSecureTextEntry = !isPasswordVisible
        isPasswordVisible.toggle()
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 회원가입 버튼 수정 호출 함수
        configureSigninButton()
        
        // 비밀번호 텍스트 필드 설정
        PasswordTextField.isSecureTextEntry = true
        PasswordConfirmTextField.isSecureTextEntry = true
        
    }
    
  
        // SigninButton - 디테일 설정하기
        private func configureSigninButton() {
      
        // SigninButton을 둥글게 만들기
        SigninButton.layer.cornerRadius = 10.0
        SigninButton.clipsToBounds = true
    }
    
    
    
        private func isValidEmail(_ email: String) -> Bool {
            // 간단한 이메일 형식 검사
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailPredicate.evaluate(with: email)
            }
    
    
    
        // 생일 유효성 검사 함수 추가
        private func isValidBirthday(_ birthday: String) -> Bool {
            return birthday.count == 8 && Int(birthday) != nil
            }
    
    
    
        // 비밀번호 유효성 검사 함수 추가
        private func isValidPassword(_ password: String) -> Bool {
            let passwordRegEx = "^(?=.*[!@#$&*])(?=.*[A-Za-z])(?=.*[0-9]).{8,}$"
            let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
            return passwordPredicate.evaluate(with: password)
            }
    
    

        
        // 사용자 등록 함수
        private func registerUser(name: String, email: String, birthday: String, password: String) {
            
            // 서버 URL 설정
            guard let url = URL(string: "https://example.com/register") else {
                showAlert(message: "잘못된 서버 주소입니다.")
            return
            }
            
            // 요청 본문 구성
            let parameters: [String: Any] = [
                "name": name,
                "email": email,
                "birthday": birthday,
                "password": password
            ]
            
            
            // 요청 구성
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                showAlert(message: "데이터 전송 오류")
                return
            }
            
            // 네트워크 요청
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                if let error = error {
                self.showAlert(message: "서버 오류: \(error.localizedDescription)")
                return
                    }
                    
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                self.showAlert(message: "서버 응답 오류")
                return
                    }
                    
                    // 성공적으로 등록된 경우
                    self.showAlert(message: "회원가입이 완료되었습니다!")
                    
                    // 서버에 데이터 보내고 유효성 검사 통과하면 "화면 전환" 시키기
                    guard let emailVerificationVC = self.storyboard?.instantiateViewController(withIdentifier: "EmailVerificationVC") as? EmailVerificationViewController else {
                        // 화면 전환 실패 시 콘솔에 오류 메시지 출력
                        print("Error: Unable to instantiate view controller with identifier 'EmailVerificationVC'")
                        return
                    }

                    // 화면 전환 애니메이션 설정
                    emailVerificationVC.modalTransitionStyle = .coverVertical
                    // 전환된 화면이 보여지는 방법 설정 (fullScreen)
                    emailVerificationVC.modalPresentationStyle = .fullScreen

                    // 화면 전환 실행
                    self.present(emailVerificationVC, animated: true, completion: nil)

                }
            }
            task.resume()
        }
        
        // 경고 메시지 표시 함수
        private func showAlert(message: String) {
            let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

