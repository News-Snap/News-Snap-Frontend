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




import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBAction func InvisibleButton(_ sender: Any) {
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
        self.presentingViewController?.dismiss(animated: true)
        
    }
    
    @IBAction func LoginButtonTapped(_ sender: Any) {
//        guard let email = EmailTextField.text, !email.isEmpty,
//                      guard let password = PasswordTextField.text, !password.isEmpty else {
//                    showAlert(message: "이메일과 비밀번호를 입력해주세요.")
//                    return
//                }
//
//                // 서버로 이메일과 비밀번호 보내기
//                login(email: email, password: password)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        configureLoginButton()

    }
    
    
    // 새로운 코드
       private func login(email: String, password: String) {
           // 여기에 서버 통신 코드를 추가하세요. 예시를 위해 URLSession을 사용합니다.
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
                    //   self.navigateToMainViewController()-----------------------------------------------------아직MainVC,API가 없음
                   }
               } else {
                   DispatchQueue.main.async {
                       self.showAlert(message: "올바른 이메일과 비밀번호인지 확인해주세요!")
                   }
               }
           }
           
           task.resume()
       }

    
    // LoginButton - 디테일 설정하기
    private func configureLoginButton() {
        
        // LoginButton을 둥글게 만들기
        LoginButton.layer.cornerRadius = 10.0
        LoginButton.clipsToBounds = true
    }
    
    
//    //  MainViewController로 화면전환 (단,서버에 저장된 이메일과 비밀번호와 사용자가 입력한 데이터가 일치할 때만)_아직 MainVC와 API가 없음
//       private func navigateToMainViewController() {
//           guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as? MainViewController else { return }
//           mainVC.modalTransitionStyle = .coverVertical
//           mainVC.modalPresentationStyle = .fullScreen
//           self.present(mainVC, animated: true, completion: nil)
//       }
       
       // 새로운 코드
       private func showAlert(message: String) {
           let alert = UIAlertController(title: "로그인 오류", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
    
  
}
    
