//
//  LoginViewController.swift
//  News-Snap
//  Created by 문정현 on 7/17/24.
//  Created by 문정현 on 8/9/24.
//
// 로그인 버튼 (LoginButtonTapped) 누르면 메인화면으로 넘어가게금 만들기
// 아직MianVC와 API가 없어서 보류!!
// LoninViewController는 바로 MainViewController로 넘어갈거

// 현재 코드는 이메일과 비밀번호가 서버에 저장된 데이터와 동일할 때 -> MianVC로 화면전환이 되게금 설정중(이하 코드 일부 에러뜨는 것만 주석처리_다른 코드의 실행 검사를 위해)

// 만약 이메일과 비밀번호가 서버에 저장된 데이터와 다르면 -> "올바른 이메일과 비밀번호인지 확인해주세요!"라는 팝업이 뜨도록 설정중(이하 코드 주석처리)

// 계정 찾기 "FindButtonTapped" 누르면 화면전환
// 회원 가입 "JoinButtonTapped" 누르면 화면전환
//
// 로그인 버튼 "LoginButtonTapped" 누르면
// 1) 만약 이메일과 비밀번호를 하나라도 입력하지 않았으면 "이메일과 비밀번호를 입력해주세요."라는 팝업(showAlert)로 띄우기
// 2) 로컬 -> 서버로 이메일과 비밀번호 데이터 보내기
// 3) 데이터 전송 중 오류 뜨면 ""네트워크 오류가 발생했습니다. 다시 시도해주세요."라는 팝업 띄우기
// 4) 서버에 있는 이메일 비밀번호면 MainVC로 이동
// 5) 아니면 "올바른 이메일과 비밀번호인지 확인해주세요!" 팝업 띄우기
// 6) 다 성공했는데 로그인이 안되면 "로그인 오류"라는 팝업 띄우기 -> 


// 문제점 : 비밀번호쪽 toggle 선적용이 안됨 -> PasswordTF버튼 만들어서 Action 함수 설정했는데도 안됨

// 나머지 문제점 해결
// API 연결 후 로그인 버튼을 누를 때 서버에 저장된 이메일과 비밀번호인지를 확인하고 넘기도록 코드 수정(현재 무지성 넘어감)


import UIKit

class LoginViewController: UIViewController {
    
    private var isPasswordVisible = false // 만약에 "isPasswordVisible" 선언이 없으면 InvisibleButton 영역 코드에서 Cannot find 'isPasswordVisible' in scope : wift 컴파일러가 isPasswordVisible 변수를 현재 범위(scope)에서 찾을 수 없다 오류뜸 -> 해결 : 변수 선언 or 선언한 위치 수정
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    
    
    @IBAction func InvisibleButtonTapped(_ sender: Any) {
        isPasswordVisible.toggle() // 새로운 코드: 토글을 먼저 수행하여 비밀번호 가시성 상태를 변경합니다.
        PasswordTextField.isSecureTextEntry = !isPasswordVisible // 새로운 코드: 비밀번호 필드의 암호화 상태를 업데이트합니다.
    }
    
    
    
    
    @IBAction func FindButtonTapped(_ sender: Any) {
        guard let EmailVerificationViewController = self.storyboard?.instantiateViewController(withIdentifier: "EmailVerificationVC") as? EmailVerificationViewController else {
            return }
        // 화면 전환 애니메이션 설정
        EmailVerificationViewController.modalTransitionStyle = .coverVertical
        // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        EmailVerificationViewController.modalPresentationStyle = .fullScreen
                self.present(EmailVerificationViewController, animated: true, completion: nil)
        
    }
    
    // JoininButton == 회원가입 변수명...
    @IBAction func JoinButtonTapped(_ sender: Any) {
        
        guard let RegisterViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as? RegisterViewController else {
            return }
        
        // 화면 전환 애니메이션 설정
        RegisterViewController.modalTransitionStyle = .coverVertical
        
        // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        RegisterViewController.modalPresentationStyle = .fullScreen
            self.present(RegisterViewController, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func BackButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true) // 이전 화면으로 넘어간다
        
    }
    
    @IBAction func LoginButtonTapped(_ sender: Any) {
        // 새로운 코드: 이메일과 비밀번호가 입력되었는지 확인
        guard let email = EmailTextField.text, !email.isEmpty,
              let password = PasswordTextField.text, !password.isEmpty else {
            showAlert(message: "이메일과 비밀번호를 입력해주세요.")
            return
        }

        // 새로운 코드: 서버로 이메일과 비밀번호 보내기
        login(email: email, password: password)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoginButton()
    }
    
    private func login(email: String, password: String) {
        let url = URL(string: "https://yourserver.com/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.showAlert(message: "네트워크 오류가 발생했습니다. 다시 시도해주세요.")
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    // 새로운 코드: 서버 응답이 성공일 경우 ScrapStatsViewController로 이동
                    self.navigateToScrapStatsViewController()
                }
            } else {
                DispatchQueue.main.async {
                    // 새로운 코드: 서버 응답이 실패일 경우 경고창 표시
                    self.showAlert(message: "이메일과 비밀번호를 다시 한 번 확인해주세요.")
                }
            }
        }
        
        task.resume()
    }
    
    private func configureLoginButton() {
        LoginButton.layer.cornerRadius = 10.0
        LoginButton.clipsToBounds = true
    }
    
    private func navigateToScrapStatsViewController() {
        guard let scrapStatsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ScrapStatsVC") as? UITabBarController else { return }
        scrapStatsViewController.modalTransitionStyle = .coverVertical
        scrapStatsViewController.modalPresentationStyle = .fullScreen
        self.present(scrapStatsViewController, animated: true, completion: nil)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "로그인 오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


