//
//  Model.swift
//  NewsSnap_real
//
//  Created by 문정현 on 8/1/24.
//

import Foundation

    // 사용자 정보를 저장하는 구조체
struct User {
    var username: String
    var Birthday: Int
    var password: String
    var Confirmpassword: String
    var email: String
    
    // 이메일이 유효한 형식인지 확인
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.email)
    }
    
    // 비밀번호가 신뢰도(?), 강력도(?) 확인 -> 추후에 추가할 후순위 기능------------------------------------------------
    func isValidPassword() -> Bool {
        // 예: 비밀번호는 최소 8자 이상이어야 함
        return self.password.count >= 8
    }
    
    // 유효성 검사       (1) 사용자 이름이 유효한지 확인 (예: 비어있지 않고 특수 문자가 없어야 함)
    func isValidUsername() -> Bool {
        let usernameRegEx = "^[a-zA-Z0-9_]{3,}$"
        let usernameTest = NSPredicate(format: "SELF MATCHES %@", usernameRegEx)
        return usernameTest.evaluate(with: self.username)
    }
    
    // 유효성 검사       (2) 모든 필드가 유효한지 확인
    func isValid() -> Bool {
        return isValidEmail() && isValidPassword() && isValidUsername()
    }
}

    // 사용자 목록을 관리하는 클래스 ( 굳이 필요하나? )
class UserModel {
    private var users: [User] = []
    
    // 새로운 사용자 추가
    func addUser(username: String, Birthday: Int, password: String, Confirmpassword: String, email: String) -> Bool {
        let newUser = User(username: username, Birthday: Birthday, password: password, Confirmpassword: Confirmpassword, email: email)
        if newUser.isValid() {
            users.append(newUser)
            return true
        }
        return false
    }
    
    // 사용자 인증
    func authenticate(username: String, password: String) -> Bool {
        for user in users {
            if user.username == username && user.password == password {
                return true
            }
        }
        return false
    }
}


//private func configurePasswordButton
//
//StartViewController
//AlarmViewController
//SelectViewController
//RegisterViewController
//LoginViewController
//EmailViewCotroller
//NewPasswordViewController
//AppDelegateViewController
//SceneDelegate
//
//private Func


