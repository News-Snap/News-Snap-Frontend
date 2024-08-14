//
//  NetworkResult.swift
//  News-Snap
//
//  Created by 선가연 on 8/14/24.
//

import Foundation

enum NetworkResult<T> {
    case success(T) // 서버 통신 성공
    case requestError(T) // 요청 오류 발생
    case pathError // 경로 오류
    case serverError // 서버 내부 오류
    case networkFail // 네트워크 연결 실패
}
