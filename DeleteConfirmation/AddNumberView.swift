//
//  AddNumberView.swift
//  DeleteConfirmation
//
//  Created by Hrishikesh on 05/10/24.
//

import SwiftUI

struct AddNumberView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var newNum: Int?
    @State private var newNumText: String = ""
    
    func saveData() {
        if let dat = newNum {
            let newFakeData = FakeData(aValue: dat)
            context.insert(newFakeData)
        }
    }
    
    var body: some View {
        VStack(alignment:.center) {
            
            TextField("Add Number", text: $newNumText)
                .keyboardType(.numberPad)
                .frame(maxWidth: .infinity, alignment:.center)
                .border(.red)
                .onChange(of: newNumText) { oldValue, newValue in
                    if let value = Int(newValue) {
                        newNum = value
                    } else if newValue.isEmpty {
                        newNum = nil
                    }
                    
                }
            
            HStack {
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
                .padding()
                Spacer()
                Button("Add number") {
                    saveData()
                    dismiss()
                }
                .disabled(newNum == nil)
                .padding()
                Spacer()
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    AddNumberView()
}
