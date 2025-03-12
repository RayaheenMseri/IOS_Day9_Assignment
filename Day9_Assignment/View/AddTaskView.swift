//
//  AddTaskView.swift
//  Day9_Assignment
//
//  Created by Taibah Valley Academy on 12/09/1446 AH.
//


import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss // Environment property to dismiss the current view when adding a task
    @State var title: String = "" // State variable to hold the input title for a new task
    @State var description: String = ""
    @ObservedObject var viewModel: TaskViewModel // Observed view model to manage the task data
    
    var body: some View {
        VStack {
            // Display the title of the view (Add New Task)
            Text("Add New Task")
                .font(.custom("MyFont", size: 24))
                .accessibilityLabel("Add New Task")
            
            // Form to input the task details
            Form {
                VStack {
                    // Label for the title field
                    Text("Title :")
                        .font(.custom("MyFont", size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityLabel("Task Title Label") // Label for the title field
                    
                    // TextField to input the task title
                    TextField("title", text: $title) // Binding the title state variable to the TextField
                        .padding()
                        .background(Color.gray.opacity(0.2)) // Light gray background color
                        .cornerRadius(5)
                        .accessibilityLabel("Enter task title") // Label for the text field
              
                    // Label for the title field
                    Text("Description :")
                        .font(.custom("MyFont", size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityLabel("Task descreption Label") // Label for the title field
                
                    // TextField to input the task title
                    TextField("description", text: $description) // Binding the title state variable to the TextField
                        .padding()
                        .background(Color.gray.opacity(0.2)) // Light gray background color
                        .cornerRadius(5)
                        .accessibilityLabel("Enter task description") // Label for the text field
                }
            }
                .scrollContentBackground(.hidden) // Hide background behind the scrollable content of the form
                
                // Add button to create a new task
                Button("Add") {
                    // Call the view model's addTask method to add a new task
                    if title.isEmpty {
                        return
                    } else {
                        viewModel.addTask(task: Task(title: title,description: description, isCompleted: false)) // Create a new task with title and default 'isCompleted' value
                        dismiss() // Dismiss the current view after adding the task
                    }
                }
                .frame(width: 150)
                .padding()
                .background(Color.newColors) // Custom background color for the button
                .foregroundColor(.white)
                .cornerRadius(10)
                .accessibilityLabel("Add Task Button") // Label for the Add button
                .accessibilityHint("Tap to add the new task.") // Provide hint about the button's functionality
            }.dynamicTypeSize(.large ... .xxLarge)
            .frame(width: 400, height: 350, alignment: .center) // Set the size and alignment of the view
        }
    }


#Preview {
    AddTaskView(viewModel: TaskViewModel())
}
