//
//  DeleteConfirmationApp.swift
//  DeleteConfirmation
//
//  Created by Hrishikesh on 05/10/24.
//

import SwiftUI
import SwiftData

@main
struct DeleteConfirmationApp: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
    
    init() {
        let schema = Schema([FakeData.self])
        let config = ModelConfiguration(schema: schema, url: URL.documentsDirectory.appending(path: "DelConf.store"))
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Unable to create container")
        }
    }
}
