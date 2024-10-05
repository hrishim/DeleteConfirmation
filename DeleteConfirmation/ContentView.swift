//
//  ContentView.swift
//  DeleteConfirmation
//
//  Created by Hrishikesh on 05/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    
    @Query(sort: \FakeData.aValue) private var fakeData: [FakeData]
    
    @State private var showingAccountAdd = false
    @State private var showDeleteConfirmation = false
    @State private var deleteOffsets: IndexSet?
    
    @State private var newNum: Int?
    @State private var newNumText: String = ""
    
    var body: some View {
        NavigationStack {
            Group {
                List {
                    ForEach(fakeData, id: \.id) { x in
                        Text("Item \(x.aValue)")
                    }
                    .onDelete(perform: preDelete)
                }
                .listStyle(.plain)
                
            }
            .navigationTitle("Items")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAccountAdd.toggle() }) {
                        Label("Add Account", systemImage: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showingAccountAdd) {
                AddNumberView()
            }
            .sheet(isPresented: $showDeleteConfirmation) {
                if let delOffsets = deleteOffsets {
                    DeleteConfirmationView(delValue: fakeData[delOffsets.first!].aValue, delIndex: delOffsets.first) {
                        realDelete(at: delOffsets)
                    }
                }
                else {
                    Text("Error")
                }
            }
            
        }
        
    }
    
    func preDelete(at offsets: IndexSet) {
        deleteOffsets = offsets
        if deleteOffsets == nil {
            print("Hello")
        }
        showDeleteConfirmation = true
    }
    
    func realDelete(at offsets: IndexSet) {
        offsets.forEach { index in
            let aData = fakeData[index]
            context.delete(aData)
        }
    }
    
}

#Preview {
    let fakeData = FakeDataPreview(FakeData.self)
    fakeData.addExamples(FakeData.sampleData)
    return ContentView()
        .modelContainer(fakeData.container)
}
