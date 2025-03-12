//
//  Task.swift
//  Day9_Assignment
//
//  Created by Taibah Valley Academy on 12/09/1446 AH.
//

import SwiftUI

class Task: Identifiable ,ObservableObject{
    let id = UUID()
    var title: String
    var description: String
    var isCompleted: Bool
    
    init(title: String, description: String, isCompleted: Bool) {
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
    }
    
}
