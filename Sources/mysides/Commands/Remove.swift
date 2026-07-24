import ArgumentParser

struct Remove: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "remove",
        abstract: "Remove a sidebar item (use \"all\" to remove everything)."
    )

    @Argument(help: "The display name of the sidebar item to remove.")
    var name: String?

    @available(macOS, deprecated: 10.11, message: "Intentionally uses deprecated LSSharedFileList API; no replacement wanted.")
    func run() throws {
        guard let name, !name.isEmpty else {
            print("No name supplied to remove!")
            throw ExitCode(1)
        }

        let status = SidebarFileList.remove(name: name)
        if status != 0 {
            throw ExitCode(status)
        }
    }
}
