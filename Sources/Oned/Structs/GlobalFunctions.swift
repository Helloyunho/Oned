//
//  GlobalFunctions.swift
//  GlobalFunctions
//
//  Created by Helloyunho on 2021/10/16.
//

import Foundation
import JavaScriptCore

let GlobalFunctions: [String: @convention(block) (JSValue) -> Any] = [
    "exit": { code in
        if code.isUndefined {
            exit(0)
        } else {
            exit(code.toInt32())
        }
    }
]
