import JavaScriptCore
import SwiftCLI

class Oned: Command {
    let name = "Oned"
    let context = JSContext()!
    
    @Param(completion: .filename)
    var file: String?
    
    func setup() {
        for elem in GlobalFunctions {
            context.globalObject.setValue(elem.value, forProperty: elem.key)
        }
        if let console = context.objectForKeyedSubscript("console") {
            for elem in ConsoleHandlers {
                console.setValue(elem.value, forProperty: elem.key)
            }
        } else {
            context.setObject(ConsoleHandlers, forKeyedSubscript: "console" as (NSCopying & NSObjectProtocol))
        }
    }
    
    func execute() throws {
        setup()
        if let file = file {
            do {
                let content = try String(contentsOfFile: file)
                context.evaluateScript(content)
                if let exception = context.exception {
                    print(exception)
                    exit(1)
                }
            } catch {
                print(error.localizedDescription)
                exit(1)
            }
        } else {
            while true {
                let input = Input.readLine(prompt: "> ")
                let value = context.evaluateScript(input)
                if let exception = context.exception {
                    print(exception)
                    context.exception = nil
                    continue
                }
                print(value ?? "undefined")
            }
        }
    }
}

let cli = CLI(
    name: "Oned",
    version: "0.0.1",
    description: "JavaScript runtime built on JavaScriptCore from WebKit.",
    commands: [Oned()]
)
cli.parser.routeBehavior = .searchWithFallback(Oned())
cli.go()
