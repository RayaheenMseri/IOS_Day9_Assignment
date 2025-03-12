//
//  TaskViewModel.swift
//  Day9_Assignment
//
//  Created by Taibah Valley Academy on 12/09/1446 AH.
//


import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = [
        Task(title: "Study", description: "Reviewing notes and preparing for exams.", isCompleted: true),
        Task(title: "HomeWork", description: "Complete math and science homework assignments.", isCompleted: false),
        Task(title: "WorkOut", description: "Morning workout: cardio and strength training.", isCompleted: true),
        Task(title: "Cleaning", description: "Tidy up the house, including vacuuming and dusting.", isCompleted: false),
        Task(title: "Shopping", description: "Buy groceries and essentials for the week.", isCompleted: true),
        Task(title: "Reading", description: "Read the assigned chapter from the novel for book club.", isCompleted: false)
    ]
    
    //add task
    func addTask(task: Task) {
        withAnimation(.easeInOut) {
            tasks.append(task)
        }
       
    }

    // delete task
    func deleteTask(at offsets: IndexSet) {
        withAnimation {
            tasks.remove(atOffsets: offsets) // Remove task with transition animation
        }
    }

    // update the completeion value when the user complete a task
    func updateTaskCompletion(task: Task, isCompleted: Bool) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted = isCompleted
        }
    }
    
    func updateTask(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
        }
    }
}
