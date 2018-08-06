//
//  FirstDataModel.swift
//  MVVMSwiftDemo
//
//  Created by yuyou on 2018/8/6.
//  Copyright © 2018年 yy. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

enum ValidationResult {
    case ok(message: String)
    case empty
    case failed(message: String)
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

class FirstDataModel: NSObject {

    var userName: String = "" // 用户名
    var password: String = "" // 密码

    let minPasswordCount = 5 // 密码最少位数

    func doLogin() -> Observable<Bool> { // 执行登录请求
        print(userName + "  " + password)
        return Observable.create({ (observer) -> Disposable in
            // 随便请求一个网站用于测试
            Alamofire.request("http://www.baidu.com", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response(completionHandler: { (response) in
                if let error = response.error {
                    observer.onError(error)
                } else {
                    observer.onNext(true)
                }
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }

    func validateUsername() -> ValidationResult { // 用户名验证
        if userName.count == 0 {
            return .empty
        }
        var haveLetter = false
        var haveNumber = false
        for c in userName {
            var intFromCharacter:Int = 0 //字符转ascii数字
            for scalar in String(c).unicodeScalars {
                intFromCharacter = Int(scalar.value)
            }
            if intFromCharacter >= 48 && intFromCharacter <= 57 { // 数字
                haveNumber = true
            }
            if intFromCharacter >= 97 && intFromCharacter <= 122 { // 小写字母
                haveLetter = true
            }
            if intFromCharacter >= 65 && intFromCharacter <= 90 { // 大写字母
                haveLetter = true
            }
        }
        if !haveLetter {
            return .failed(message: "用户名必须包含英文字母")
        }
        if !haveNumber {
            return .failed(message: "用户名必须包含数字")
        }
        return .ok(message: "用户名可用")
    }

    func validatePassword() -> ValidationResult { // 密码验证
        if password.count == 0 {
            return .empty
        }
        if password.count < minPasswordCount {
            return .failed(message: "密码不得少于 \(minPasswordCount) 位")
        }
        return .ok(message: "密码可用")
    }
}
