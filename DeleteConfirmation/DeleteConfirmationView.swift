//
//  DeleteConfirmationView.swift
//  DeleteConfirmation
//
//  Created by Hrishikesh on 05/10/24.
//

import SwiftUI

struct DeleteConfirmationView: View {
    @Environment(\.dismiss) var dismiss
    
    let delValue: Int?

    var onDelete: () -> Void
    
    var body: some View {
        if let delv = delValue {
            Text("Deleting \(delv)")
        } else {
            Text("Error")
        }
            
        HStack {
            Spacer()
            Button("Cancel") {
                dismiss()
            }
            .padding()
            Spacer()
            Button("Delete number") {
                onDelete()
                dismiss()
            }
            .disabled(delValue == nil)
            .padding()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    let fakeData = FakeDataPreview(FakeData.self)
    fakeData.addExamples(FakeData.sampleData)
    
    func removeAccounts() {
        
    }
    
    return NavigationStack {
        DeleteConfirmationView(delValue: 0, onDelete: removeAccounts)
            .modelContainer(fakeData.container)
    }
}
