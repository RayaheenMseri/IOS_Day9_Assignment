//
//  EditTaskView.swift
//  Day9_Assignment
//
//  Created by Taibah Valley Academy on 12/09/1446 AH.
//


import SwiftUI

struct EditTaskView: View {
    @Environment(\.dismiss) private var dismiss // Environment property to dismiss the current view when adding a task
    @State var title: String = "" // State variable to hold the input title for a new task
    @State var description: String = ""
    @ObservedObject var details: Task // Observed view model to manage the task data
    @ObservedObject var taskModel: TaskViewModel // ViewModel to manage the tasks, marked with @StateObject for ownership

    var body: some View {
        VStack {
            // Display the title of the view (edit Task)
            Text("Edit Task")
                .font(.headline)
                .accessibilityLabel("Edit Task")
            
            // Form to edit the task details
            Form {
                VStack {
                    // Label for the title field
                    Text("Title :")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityLabel("Task Title Label") // Label for the title field
                    
                    // TextField to input the task title
                    TextField("\(details.title)", text: $title) // Binding the title state variable to the TextField
                        .padding()
                        .background(Color.gray.opacity(0.2)) // Light gray background color
                        .cornerRadius(5)
                        .accessibilityLabel("Enter task title") // Label for the text field
              
                    // Label for the title field
                    Text("Description :")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityLabel("Task descreption Label") // Label for the title field
                
                    // TextField to input the task title
                    TextField("\(details.description)", text: $description) // Binding the title state variable to the TextField
                        .padding()
                        .background(Color.gray.opacity(0.2)) // Light gray background color
                        .cornerRadius(5)
                        .accessibilityLabel("Enter task description") // Label for the text field
                }
            }
                .scrollContentBackground(.hidden) // Hide background behind the scrollable content of the form
                
                // edit button to edit existing task
            Button("Save") {
                details.title = title
                details.description = description
                // Call the view model's updatetask method to update the task task
                taskModel.updateTask(task: details)
                dismiss()
                
                }
                .frame(width: 150)
                .padding()
                .background(Color.newColors) // Custom background color for the button
                .foregroundColor(.white)
                .cornerRadius(10)
                .accessibilityLabel("edit Task Button") // Label for the edit button
                .accessibilityHint("Tap to edit the task.") // Provide hint about the button's functionality
            }.dynamicTypeSize(.large ... .xxLarge)
            .frame(width: 400, height: 350, alignment: .center) // Set the size and alignment of the view
        }
    }


#Preview {
    EditTaskView(details: Task(title: "string", description: "String", isCompleted: true), taskModel: TaskViewModel())
}
