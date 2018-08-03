//
//  FirstApi.swift
//  MVVMSwiftDemo
//
//  Created by yuyou on 2018/8/3.
//  Copyright © 2018年 yy. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

class FirstApi {

    static let shared = FirstApi()

    func doLogin(username: String, password: String) -> Observable<Bool> {
        print(username + "  " + password)
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
}
