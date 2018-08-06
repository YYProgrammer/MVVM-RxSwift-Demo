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

class FirstViewModel {

    private let dataModel: FirstDataModel = FirstDataModel()
    private let disposeBag = DisposeBag()
    private var validatedUsername: Variable<ValidationResult> = Variable(.empty)
    private var validatedPassword: Variable<ValidationResult> = Variable(.empty)

    init(nameTextField: TipTextField, pwdTextField: TipTextField, loginButton: UIButton) {

        //姓名输入时，dataModel的userName随之变化，并检测合法性
        nameTextField.textField.rx.text.orEmpty.asDriver()
            .drive(onNext: { [unowned self] (userName) in
                self.dataModel.userName = userName
                self.validatedUsername.value = self.dataModel.validateUsername()
            })
            .disposed(by: disposeBag)

        //密码输入时，dataModel的password随之变化，并检测合法性
        pwdTextField.textField.rx.text.orEmpty.asDriver()
            .drive(onNext: { [unowned self] (password) in
                self.dataModel.password = password
                self.validatedPassword.value = self.dataModel.validatePassword()
            })
            .disposed(by: disposeBag)

        //姓名合法性变化时，label展示效果随之变化
        validatedUsername.asDriver()
            .drive(nameTextField.tipLabel.rx.validationResult)
            .disposed(by: disposeBag)

        //密码合法性变化时，label展示效果随之变化
        validatedPassword.asDriver()
            .drive(pwdTextField.tipLabel.rx.validationResult)
            .disposed(by: disposeBag)

        //绑定姓名密码合法性结果，判断button能否点击
        Driver.combineLatest(validatedUsername.asDriver(), validatedPassword.asDriver()) { username, password in
                username.isValid && password.isValid
            }
            .distinctUntilChanged()
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)

        //button点击，绑定请求结果
        loginButton.rx.tap.asDriver()
            .flatMapLatest { [unowned self] _ in
                return self.dataModel.doLogin().asDriver(onErrorJustReturn: false)
            }
            .drive(loginButton.rx.loginResult)
            .disposed(by: disposeBag)
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
