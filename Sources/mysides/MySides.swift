import ArgumentParser

let mysidesVersion = "1.0.1"

let legacyHelpText = """
Usage: mysides list|add <name> <uri>|remove <name>

\t list - list sidebar items
\t add - append a sidebar item to the end of the list
\t remove - remove a sidebar item
\t version - display the version

"""

struct MySides: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "mysides",
        abstract: "A simple CLI tool for Finder sidebar modification.",
        version: mysidesVersion,
        subcommands: [List.self, Add.self, Insert.self, Remove.self, Version.self]
    )
}
