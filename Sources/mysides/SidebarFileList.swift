@preconcurrency import CoreServices
import Foundation

private typealias InsertItemURLFunction = @convention(c) (
    LSSharedFileList,
    UnsafeMutableRawPointer,
    CFString?,
    UnsafeMutableRawPointer?,
    CFURL,
    CFDictionary?,
    CFArray?
) -> Unmanaged<LSSharedFileListItem>?

private let rawInsertItemURL: InsertItemURLFunction = {
    guard let symbol = dlsym(dlopen(nil, RTLD_NOW), "LSSharedFileListInsertItemURL") else {
        fatalError("LSSharedFileListInsertItemURL symbol not found")
    }
    return unsafeBitCast(symbol, to: InsertItemURLFunction.self)
}()

@available(macOS, deprecated: 10.11, message: "Intentionally uses deprecated LSSharedFileList API; no replacement wanted.")
enum SidebarFileList {

    static func list() {
        guard let sflRef = LSSharedFileListCreate(kCFAllocatorDefault, kLSSharedFileListFavoriteItems.takeUnretainedValue(), nil)?.takeRetainedValue() else {
            print("No list!", terminator: "")
            return
        }

        for item in snapshot(of: sflRef) {
            let name = displayName(of: item)
            if let url = resolvedURL(of: item) {
                print("\(name) -> \(url.absoluteString)")
            } else {
                print("\(name) -> NOTFOUND")
            }
        }
    }

    static func add(name: String, url: URL) -> Int32 {
        guard let sflRef = LSSharedFileListCreate(kCFAllocatorDefault, kLSSharedFileListFavoriteItems.takeUnretainedValue(), nil)?.takeRetainedValue() else {
            print("Unable to create sidebar list, LSSharedFileListCreate() fails.", terminator: "")
            return 2
        }

        _ = rawInsertItemURL(sflRef, kLSSharedFileListItemLast.toOpaque(), name as CFString, nil, url as CFURL, nil, nil)
        print("Added sidebar item with name: \(name)")
        return 0
    }

    static func insert(name: String, url: URL) -> Int32 {
        guard let sflRef = LSSharedFileListCreate(kCFAllocatorDefault, kLSSharedFileListFavoriteItems.takeUnretainedValue(), nil)?.takeRetainedValue() else {
            print("Unable to create sidebar list, LSSharedFileListCreate() fails.", terminator: "")
            return 2
        }

        _ = rawInsertItemURL(sflRef, kLSSharedFileListItemBeforeFirst.toOpaque(), name as CFString, nil, url as CFURL, nil, nil)
        print("Inserted sidebar item at beginning of list with name: \(name)")
        return 0
    }

    static func remove(name: String) -> Int32 {
        guard let sflRef = LSSharedFileListCreate(kCFAllocatorDefault, kLSSharedFileListFavoriteItems.takeUnretainedValue(), nil)?.takeRetainedValue() else {
            print("Unable to create sidebar list, LSSharedFileListCreate() fails.", terminator: "")
            return 2
        }

        if name.lowercased() == "all" {
            LSSharedFileListRemoveAllItems(sflRef)
            return 0
        }

        for item in snapshot(of: sflRef) {
            if displayName(of: item) == name {
                LSSharedFileListItemRemove(sflRef, item)
                print("Removed sidebar item with name: \(name)")
                return 0
            }
        }

        print("Could not find sidebar item with display name: \(name)")
        return 1
    }

    private static func snapshot(of sflRef: LSSharedFileList) -> [LSSharedFileListItem] {
        var seed: UInt32 = 0
        guard let items = LSSharedFileListCopySnapshot(sflRef, &seed)?.takeRetainedValue() as? [LSSharedFileListItem] else {
            return []
        }
        return items
    }

    private static func displayName(of item: LSSharedFileListItem) -> String {
        LSSharedFileListItemCopyDisplayName(item).takeRetainedValue() as String
    }

    private static func resolvedURL(of item: LSSharedFileListItem) -> URL? {
        let flags: LSSharedFileListResolutionFlags = UInt32(kLSSharedFileListNoUserInteraction | kLSSharedFileListDoNotMountVolumes)
        guard let cfURL = LSSharedFileListItemCopyResolvedURL(item, flags, nil) else {
            return nil
        }
        return cfURL.takeRetainedValue() as URL
    }
}
