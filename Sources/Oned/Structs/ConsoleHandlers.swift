//
//  ConsoleHandlers.swift
//  ConsoleHandlers
//
//  Created by Helloyunho on 2021/10/16.
//

import Foundation
import JavaScriptCore

let ConsoleHandlers: [String: @convention(block) (JSValue) -> Void] = [
    "log": { value in
        if value.isUndefined {
            print()
        } else {
            print(value)
        }
    },
    "error": { value in
        if value.isUndefined {
            print()
        } else {
            print(value)
        }
    }
]
