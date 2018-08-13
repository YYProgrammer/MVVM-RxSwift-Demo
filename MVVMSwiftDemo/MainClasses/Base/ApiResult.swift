//
// Created by Ren on 2018/8/13.
// Copyright (c) 2018 yy. All rights reserved.
//

import Foundation

class ApiResult {

    static var UnhandledException: ApiResult {
        return ApiResult(name: "UnhandledException", message: "", data: "")
    }

    static func success(_ message: String = "", _ data: Any = "") -> ApiResult {
        return ApiResult(name: "", message: message, data: data)
    }

    static func failure(_ name: String, _ message: String = "", _ data: Any = "") -> ApiResult {
        if(name.isEmpty) {
            print("Warning: name required")
        }
        return ApiResult(name: name, message: message, data: data)
    }

    static func failure(_ error: Error) -> ApiResult {
        return ApiResult(name: "", message: "", data: "")
    }

    let name: String
    let message: String
    let data: Any

    init(name: String, message: String, data: Any) {
        self.name = name
        self.message = message
        self.data = data
    }

    var isSuccess: Bool {
        return name.count == 0
    }
}