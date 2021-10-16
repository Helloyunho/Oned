import JavaScriptCore
import SwiftCLI

let context = JSContext()

struct ConsoleHandlers {
    static let log: @convention(block) (JSValue) -> Void = { value in
        if value.isUndefined {
            print()
        } else {
            print(value)
        }
    }
}

context?.objectForKeyedSubscript("console")?.setValue(ConsoleHandlers.log, forProperty: "log")

while true {
    let input = Input.readLine(prompt: "> ")
    let value = context?.evaluateScript(input)
    print(value ?? "undefined")
}
