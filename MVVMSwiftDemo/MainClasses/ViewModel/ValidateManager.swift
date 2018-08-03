//
//  ValidateManager.swift
//  MVVMSwiftDemo
//
//  Created by yuyou on 2018/8/2.
//  Copyright © 2018年 yy. All rights reserved.
//

import UIKit

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

    var textColor: UIColor {
        switch self {
        case .ok:
            return UIColor.green
        case .empty:
            return UIColor.black
        case .failed:
            return UIColor.red
        }
    }

    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case let .failed(message):
            return message
        }
    }
}

class ValidateManager {

    static let sharedManager = ValidateManager() // 单粒

    let minPasswordCount = 5

    func validateUsername(username: String) -> ValidationResult { // 用户名验证
        if username.count == 0 {
            return .empty
        }
        var haveLetter = false
        var haveNumber = false
        for c in username {
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

    func validatePassword(password: String) -> ValidationResult { // 密码验证
        if password.count == 0 {
            return .empty
        }
        if password.count < minPasswordCount {
            return .failed(message: "密码不得少于 \(minPasswordCount) 位")
        }
        return .ok(message: "密码可用")
    }
}
