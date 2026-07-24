## mysides

A small, fast CLI for managing Finder sidebar favorites on macOS, built in
Swift on top of the deprecated but still functional `LSSharedFileList` API.

> Requires macOS 26.1 or later.

## Features

- List, add, insert, and remove Finder sidebar favorite items
- Single static binary, no dependencies to install
- Scriptable, easy to drop into setup scripts or dotfiles

## Install

### Manually
See [Releases](https://github.com/jeremy4971/mysides-swift/releases)

### Homebrew
    brew install jeremy4971/mysides-swift/mysides-swift

### Shell script
    curl -fsSL https://raw.githubusercontent.com/jeremy4971/mysides-swift/9a81577b5e3a0c2f8ed10d80cf92f222e7012fdd/install.sh | bash

## Usage

**List** sidebar favorite items:

```sh
mysides list
```

**Add** a new item to the end of the list:

```sh
mysides add Pictures file:///Users/yourName/Pictures/
```

**Insert** a new item at the start of the list:

```sh
mysides insert Pictures file:///Users/yourName/Pictures/
```

**Remove** an item by name:

```sh
mysides remove Pictures
```

**Show** the installed version:

```sh
mysides version
```

## Build from source

```sh
swift build -c release --scratch-path build
```

The executable is produced at `build/release/mysides`. Copy it wherever you
need it, e.g.:

```sh
cp build/release/mysides /usr/local/bin/
```
## Credits

This repository is a Swift port of the original tool by Mosen.

## License

MIT - see [LICENSE](LICENSE).
