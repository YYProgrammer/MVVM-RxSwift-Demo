//
//  FirstViewModel.swift
//  MVVMSwiftDemo
//
//  Created by yuyou on 2018/8/2.
//  Copyright © 2018年 yy. All rights reserved.
//

import RxSwift
import RxCocoa

class FirstViewModel {

    let validatedUsername: Driver<ValidationResult>
    let validatedPassword: Driver<ValidationResult>
    let signupEnabled: Driver<Bool>
    let login: Driver<Bool>

    init(input: (username: Driver<String>, password: Driver<String>, loginTaps: Driver<()>),
        validateManager: ValidateManager) {

        validatedUsername = input.username
            .map { username in
                return validateManager.validateUsername(username: username)
            }

        validatedPassword = input.password
            .map { password in
                return validateManager.validatePassword(password: password)
            }

        signupEnabled = Driver.combineLatest(validatedUsername, validatedPassword) { username, password in
            username.isValid && password.isValid
        }.distinctUntilChanged()

        login = input.loginTaps
            .withLatestFrom(
                Driver.combineLatest(input.username, input.password) { u, p in
                    (username: u, password: p)
                }
            )
            .flatMapLatest { pair in
                return FirstApi.shared.doLogin(username: pair.username, password: pair.password)
                    .asDriver(onErrorJustReturn: false)
            }
    }
}

extension Reactive where Base: UILabel {
    var validationResult: Binder<ValidationResult> {
        return Binder(base) { label, result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}

extension Reactive where Base: UIButton {
    var loginResult: Binder<Bool> {
        return Binder(base) { button, result in
            if !result {
                button.setTitle("登录失败，请重新登录", for: .normal)
            } else {
                button.setTitle("登录成功", for: .disabled)
                button.isEnabled = false
            }
        }
    }
}


