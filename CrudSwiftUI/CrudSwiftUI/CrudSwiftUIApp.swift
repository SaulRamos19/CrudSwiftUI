import SwiftUI

@main
struct CrudSwiftUIApp: App {
    let coreDM = CoreDataManager()
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: coreDM)
        }
    }
}
