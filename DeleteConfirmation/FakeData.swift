//
//  FakeData.swift
//  DeleteConfirmation
//
//  Created by Hrishikesh on 05/10/24.
//

import Foundation
import SwiftData

@Model
class FakeData {
    var id = UUID()
    var aValue: Int
    
    init(aValue: Int) {
        self.aValue = aValue
    }
}
