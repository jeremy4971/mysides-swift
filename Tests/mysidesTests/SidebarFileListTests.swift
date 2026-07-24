import Foundation
import Testing
@testable import mysides

@Suite
struct SidebarFileListTests {
    @Test func list() {
        SidebarFileList.list()
    }

    @Test func add() {
        let status = SidebarFileList.add(name: "Test", url: URL(string: "file:///tmp")!)
        #expect(status == 0)
    }

    @Test func removeAll() {
        let status = SidebarFileList.remove(name: "all")
        #expect(status == 0)
    }
}
