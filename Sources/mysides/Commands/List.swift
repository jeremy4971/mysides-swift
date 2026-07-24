import ArgumentParser

struct List: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "list",
        abstract: "List sidebar items."
    )

    @available(macOS, deprecated: 10.11, message: "Intentionally uses deprecated LSSharedFileList API; no replacement wanted.")
    func run() {
        SidebarFileList.list()
    }
}
