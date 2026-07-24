import ArgumentParser
import Foundation

struct Insert: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "insert",
        abstract: "Insert a sidebar item at the start of the list."
    )

    @Argument(help: "The display name for the sidebar item.")
    var name: String?

    @Argument(help: "The file:// URI to add.")
    var uri: String?

    @available(macOS, deprecated: 10.11, message: "Intentionally uses deprecated LSSharedFileList API; no replacement wanted.")
    func run() throws {
        guard let name else {
            print("No display name supplied to insert!", terminator: "")
            throw ExitCode(1)
        }
        guard let uri else {
            print("No path supplied to insert!", terminator: "")
            throw ExitCode(1)
        }
        guard let url = URL(string: uri) else {
            print("Invalid path supplied to insert!", terminator: "")
            throw ExitCode(1)
        }

        let status = SidebarFileList.insert(name: name, url: url)
        if status != 0 {
            throw ExitCode(status)
        }
    }
}
