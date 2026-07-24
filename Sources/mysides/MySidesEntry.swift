import ArgumentParser

@main
struct MySidesEntry {
    static func main() {
        let args = Array(CommandLine.arguments.dropFirst())
        if args.isEmpty {
            print(legacyHelpText, terminator: "")
            MySides.exit(withError: ExitCode(1))
        }
        MySides.main(args)
    }
}
