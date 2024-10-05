//
//  FakeDataPreview.swift
//  DeleteConfirmation
//
//  Created by Hrishikesh on 05/10/24.
//

import Foundation
import SwiftData

struct FakeDataPreview {
    let container: ModelContainer
    
    init(_ models: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(models)
        
        do {
            container = try ModelContainer(for: schema, configurations:  config)
        } catch {
            fatalError("Unable to create preview container.")
        }
    }
    
    func addExamples(_ examples: [any PersistentModel]) {
        Task { @MainActor in
            examples.forEach { example in
                container.mainContext.insert(example)
                
            }
        }
    }
}
