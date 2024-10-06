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
    @State private var itemToDelete: FakeData?
    
    @State private var newNum: Int?
    @State private var newNumText: String = ""
    
    var body: some View {
        NavigationStack {
            Group {
                //NOTE: Adding this line makes the bug go away!!
                let _ = itemToDelete
                
                List {
                    ForEach(fakeData, id: \.id) { item in
                        Text("Item \(item.aValue)")
                            .swipeActions {
                                Button(role: .destructive) {
                                    self.itemToDelete = item
                                    showDeleteConfirmation = true
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
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
                
                if let item2Delete = self.itemToDelete {
                    DeleteConfirmationView(delValue: item2Delete.aValue) {
                        realDelete(item: itemToDelete)
                    }
                }
                else {
                    Text("Error")
                }
            }
        }
        .onAppear {
            print("View updated")
        }
    }
    
    func preDelete(item anItem: FakeData) {
        print("Predelete called")
        self.itemToDelete = anItem
        if self.itemToDelete == nil {
            print("Expect error")
        } else {
            print("Should be ok.")
        }
        
        showDeleteConfirmation = true
        
        // Note: Delaying also does no good
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
        //            showDeleteConfirmation = true
        //        }
    }
    
    func realDelete(item anItem: FakeData?) {
        if let realItem = anItem {
            context.delete(realItem)
        }
        
    }
    
}

#Preview {
    let fakeData = FakeDataPreview(FakeData.self)
    fakeData.addExamples(FakeData.sampleData)
    return ContentView()
        .modelContainer(fakeData.container)
}
