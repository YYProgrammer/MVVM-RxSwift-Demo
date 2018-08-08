//
//  TestViewModel.swift
//  MVVMSwiftDemo
//
//  Created by yuyou on 2018/8/6.
//  Copyright © 2018年 yy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension ValidationResult { // 这个扩展定义在这里，因为它跟view层联系更紧密
    var textColor: UIColor {
        switch self {
        case .ok:
            return .green
        case .empty:
            return .clear
        case .failed:
            return .red
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

class FirstViewModel {

    private let dataModel: FirstDataModel = FirstDataModel()
    private let disposeBag = DisposeBag()

    var username = Variable("") // 用户名
    var usernameMessage: Variable<(isValid: Bool, str: String, color: UIColor)> = Variable((isValid: false, str: "", color: .clear)) // 用户名验证提示信息
    var password = Variable("") // 密码
    var passwordMessage: Variable<(isValid: Bool, str: String, color: UIColor)> = Variable((isValid: false, str: "", color: .clear)) // 密码验证提示信息
    var loginEnable = Variable(false)  // 按钮是否可以点击
    var totalTipString: Variable<(str: String, color: UIColor)> = Variable((str: "", color: .clear)) // 总的提示文字
    var loginTap = Variable(Void.self) // 按钮点击信号

    init() {
        username.value = "test" // 测试，给输入框附一个初始值
        password.value = "test" // 测试，给输入框附一个初始值

        username.asDriver().drive(onNext: { [unowned self] (username) in
            self.dataModel.userName = username
            let result = self.dataModel.validateUsername()
            self.usernameMessage.value = (isValid: result.isValid, str: result.description, color: result.textColor)
        }).disposed(by: disposeBag)

        password.asDriver().drive(onNext: { [unowned self] (password) in
            self.dataModel.password = password
            let result = self.dataModel.validatePassword()
            self.passwordMessage.value = (isValid: result.isValid, str: result.description, color: result.textColor)
        }).disposed(by: disposeBag)

        Driver.combineLatest(usernameMessage.asDriver(), passwordMessage.asDriver()) { (username, password) -> (enable: Bool, tipStr: String) in
            var total: (enable: Bool, tipStr: String) = (enable: false, tipStr: "")
            total.enable = username.isValid && password.isValid
            if !username.isValid {
                total.tipStr += username.str
                total.tipStr += "  "
            }
            if !password.isValid {
                total.tipStr += password.str
            }
            return total
        }
        .drive(onNext: { [unowned self] in
            self.loginEnable.value = $0.enable
            self.totalTipString.value = (str: $0.tipStr, color: .red)
        })
        .disposed(by: disposeBag)

        loginTap.asDriver().skip(1)
            .flatMapLatest{ [unowned self] _ in
                return self.dataModel.doLogin().asDriver(onErrorJustReturn: false)
            }
            .drive(onNext: { [unowned self] in
                if !$0 {
                    self.totalTipString.value = (str: "登录失败", color: .red)
                } else {
                    self.totalTipString.value = (str: "登录成功", color: .green)
                }
            })
            .disposed(by: disposeBag)
    }
}
