
//
//  ContentView.swift
//  Day9_Assignment
//
//  Created by Taibah Valley Academy on 12/09/1446 AH.
//


import SwiftUI

struct ContentView: View {
    @State private var isDarkMode = false   // State variable to manage Dark Mode toggle
    @State private var newTask = ""         // State variable to hold the input for a new task
    @StateObject var taskModel = TaskViewModel() // ViewModel to manage the tasks, marked with @StateObject for ownership

    var body: some View {
        NavigationStack {
            VStack(spacing: 2) {  // Vertical stack with minimal spacing between views
                ZStack(alignment:.bottomTrailing){ // ZStack to overlay UI elements, aligned to the bottom right
                    // Check if there are no tasks in the task model
                    if taskModel.tasks.isEmpty {
                        Text("No Tasks Found")
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .foregroundColor(.newColors)
                            .accessibilityLabel("No tasks found") // Accessible label for no tasks state
                            .accessibilityHint("You can add tasks by tapping the plus button.") // Hint for users on what to do next// Custom color for the message
                    } else {
                        // Display tasks in a list if there are any tasks
                        List {
                            ForEach(taskModel.tasks.sorted { !$0.isCompleted && $1.isCompleted }) { task in
                                HStack {
                                    
                                    // Button to toggle the completion status of the task
                                    Button(action: {
                                        taskModel.updateTaskCompletion(task: task, isCompleted: !task.isCompleted)
                                    }) {
                                        // Display either a checked or unchecked box based on the task's completion state
                                        Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                                            .foregroundColor(task.isCompleted ? .newColors : .newColors)
                                            .frame(width: 30, height: 30)
                                            .accessibilityLabel(task.isCompleted ? "Mark as incomplete" : "Mark as completed") // Label for the checkbox
                                    }.padding(.leading,10)
                                    // Task title displayed in a row with some padding
                                    Text(task.title)
                                        .font(.custom("MyFont", size: 18))
                                        .foregroundColor(.primary)
                                        .frame(width: 200, alignment: .leading)
                                        .padding(.vertical)
                                        .accessibilityLabel("Task Title: \(task.title)") // Label the task title for VoiceOver
                                        .accessibilityHint(task.isCompleted ? "This task is completed." : "This task is not completed.") // Provide a hint about task completion status

                                    Spacer() // Spacer to push the checkmark button to the right

                                    NavigationLink {
                                        TaskDetailsView(details: task, taskModel: taskModel)
                                    } label: {
                                        Text("")  // Empty text so that the navigation link itself is invisible
                                    }.padding()
                                    
                                }
                                .transition(.slide)
                                .background(.gray.opacity(0.1))
                                .cornerRadius(10)
                                .accessibilityElement(children: .ignore) // Ignore the background view in accessibility traversal
                            }
                            .onDelete(perform: taskModel.deleteTask) // Allow swipe-to-delete gesture on tasks
                        }
                        .frame(maxWidth:.infinity) // Ensure the list takes up full width
                        .navigationTitle("Tasks List") // Set the navigation title for the list of tasks
                    }

                    // Button to navigate to AddUserView for adding a new task
                    NavigationLink(destination: AddTaskView(viewModel: taskModel)) {
                        Image(systemName: "plus")
                            .font(.title.weight(.semibold)) // Plus icon with bold weight
                            .padding()
                            .background(Color.newColors) // Custom background color for the button
                            .foregroundColor(.white)
                            .clipShape(Circle()) // Circular button shape
                            .accessibilityLabel("Add a new task") // Label for the add task button
                            .accessibilityHint("Tap to navigate to the screen where you can add a new task.") // Hint for the button's action
                    }
                }
                }
            .toolbar {
                // Toolbar with Edit button on the top right of the navigation bar
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .foregroundColor(Color("CustomColors")) // Custom color for the Edit button
                        .accessibilityLabel("Edit tasks") // Label for the edit button
                }

                // Toolbar with a Toggle button for Dark Mode on the top left of the navigation bar
                ToolbarItem(placement: .navigationBarLeading) {
                    Toggle("Enable Dark Mode", isOn: $isDarkMode)  // Toggle to enable or disable Dark Mode
                        .accentColor(.newColors)  // Custom color for the toggle switch
                        .padding()
                        .accessibilityLabel("Enable or disable Dark Mode") // Label for the dark mode toggle
                        .accessibilityHint("Toggle the appearance of the app between light and dark modes.") // Provide a hint for dark mode toggle
                        .accessibilityHidden(false)
                }
            }
            .scrollContentBackground(.hidden) // Hide the background behind the scroll view
            .padding() // Add padding around the entire content view
            .preferredColorScheme(isDarkMode ? .dark : .light) // Set the color scheme based on the Dark Mode toggle
        }.dynamicTypeSize(.large ... .xxLarge)
    }
}

#Preview {
    ContentView()
}
