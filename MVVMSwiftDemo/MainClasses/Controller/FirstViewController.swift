//
//  FirstViewController.swift
//  MVVMSwiftDemo
//
//  Created by yuyou on 2018/8/1.
//  Copyright © 2018年 yy. All rights reserved.
//

import UIKit
import RxSwift

class FirstViewController: UIViewController {

    

    // 取消订阅的标记，可以写到父类里
    var disposeBag = DisposeBag()

    // MARK: 界面组件
    private lazy var nameTextField: TipTextField = {
        let textfield = TipTextField.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: 70.0), placeHolder: "输入姓名")
        return textfield
    }()
    private lazy var pwdTextField: TipTextField = {
        let textfield = TipTextField.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: 70.0), placeHolder: "输入密码")
        return textfield
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 15.0, y: 0, width: kMainScreenWidth - 2 * 15.0, height: 44.0))
        button.setTitle("登录", for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: UIColorFromRGB(hexValue: "FF6600")), for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: UIColorFromRGB(hexValue: "FF5C00")), for: .highlighted)
        button.setBackgroundImage(UIImage.imageWithColor(color: UIAlphaColorFromRGB(hexValue: "FF6600", alpha: 0.5)), for: .disabled)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // 添加子控件
        view.addSubview(nameTextField)
        view.addSubview(pwdTextField)
        view.addSubview(loginButton)
        // 布局子控件
        nameTextField.yy_y = STATUS_HEIGHT + 20.0
        pwdTextField.yy_y = nameTextField.yy_bottom + 10.0
        loginButton.yy_y = pwdTextField.yy_bottom + 40.0

        //绑定viewModel
        let viewModel = FirstViewModel.init(input: (username: nameTextField.textField.rx.text.orEmpty.asDriver(),
                                                    password: pwdTextField.textField.rx.text.orEmpty.asDriver(),
                                                    loginTaps: loginButton.rx.tap.asDriver()),
                                            validateManager: ValidateManager.sharedManager)

        viewModel.validatedUsername
            .drive(nameTextField.tipLabel.rx.validationResult)
            .disposed(by: disposeBag)

        viewModel.validatedPassword
            .drive(pwdTextField.tipLabel.rx.validationResult)
            .disposed(by: disposeBag)

        viewModel.signupEnabled
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)

//        viewModel.login.drive(onNext: { [unowned self] (login) in
//            if !login {
//                self.loginButton.setTitle("登录失败，请重新登录", for: .normal)
//            } else {
//                self.loginButton.setTitle("登录成功", for: .disabled)
//                self.loginButton.isEnabled = false
//            }
//        }).disposed(by: disposeBag)
        viewModel.login
            .drive(loginButton.rx.loginResult)
            .disposed(by: disposeBag)
    }


}
