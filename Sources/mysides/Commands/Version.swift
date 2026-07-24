import ArgumentParser

struct Version: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "version",
        abstract: "Display the version."
    )

    func run() {
        print("mysides v\(mysidesVersion)")
    }
}
