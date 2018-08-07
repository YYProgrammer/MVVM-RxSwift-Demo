//
//  FirstViewController.swift
//  MVVMSwiftDemo
//
//  Created by yuyou on 2018/8/1.
//  Copyright © 2018年 yy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FirstViewController: UIViewController {

    private let disposeBag = DisposeBag()

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
    private lazy var totalTipLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: 20.0))
        label.textColor = .red
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()

    // MARK: viewModel
    private var viewModel: FirstViewModel = FirstViewModel.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // 添加子控件
        view.addSubview(nameTextField)
        view.addSubview(pwdTextField)
        view.addSubview(loginButton)
        view.addSubview(totalTipLabel)
        // 布局子控件
        nameTextField.yy_y = STATUS_HEIGHT + 20.0
        pwdTextField.yy_y = nameTextField.yy_bottom + 10.0
        loginButton.yy_y = pwdTextField.yy_bottom + 40.0
        totalTipLabel.yy_centerY = kMainScreenHeight * 0.5
        //绑定viewModel
        viewModel.username.asDriver()
            .drive(nameTextField.textField.rx.text)
            .disposed(by: disposeBag)

        nameTextField.textField.rx.text.orEmpty.asDriver()
            .drive(viewModel.username)
            .disposed(by: disposeBag)

        viewModel.usernameMessage.asDriver()
            .drive(onNext: { [unowned self] in
                self.nameTextField.tipLabel.text = $0.str
                self.nameTextField.tipLabel.textColor = $0.color
            })
            .disposed(by: disposeBag)

        viewModel.password.asDriver()
            .drive(pwdTextField.textField.rx.text)
            .disposed(by: disposeBag)

        pwdTextField.textField.rx.text.orEmpty.asDriver()
            .drive(viewModel.password)
            .disposed(by: disposeBag)
        
        viewModel.passwordMessage.asDriver()
            .drive(onNext: { [unowned self] in
                self.pwdTextField.tipLabel.text = $0.str
                self.pwdTextField.tipLabel.textColor = $0.color
            })
            .disposed(by: disposeBag)

        viewModel.loginEnable.asDriver()
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)

        viewModel.totalTipString.asDriver()
            .drive(onNext: { [unowned self] in
                self.totalTipLabel.text = $0.str
                self.totalTipLabel.textColor = $0.color
            })
            .disposed(by: disposeBag)

        loginButton.rx.tap.asDriver()
            .drive(onNext: { [unowned self] in
                self.viewModel.loginTap.value = 1
            })
            .disposed(by: disposeBag)
    }
}
