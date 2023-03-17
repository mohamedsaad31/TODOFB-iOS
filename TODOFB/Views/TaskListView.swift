//
//  ContentView.swift
//  TODOFB
//
//  Created by mohamed saad on 09/03/2023.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    //declar flag to hide and show specific cell when user press (Add New task)
    @State var presentAddNewItem = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List{
                    ForEach(taskListVM.TaskCellViewModels) { taskCellVM in
                        TaskCell(taskCellVM: taskCellVM)
                    }
                    if presentAddNewItem{
                        TaskCell(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false))){task in
                          self.taskListVM.addTask(task: task)
                            //when insert done so we hide the textfield
                          self.presentAddNewItem.toggle()
                        }
                    }
                }
                Spacer()
                HStack(alignment: .top) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blue)
                    Button("Add New Task") {
                        self.presentAddNewItem.toggle()
                    }
                }
                .padding()
            }
            .navigationBarTitle("Tasks")
        }
        .padding(.leading, -8.0)
    }
}

struct TaskCell: View {
    
    @ObservedObject var taskCellVM: TaskCellViewModel
    //when user make changes on the cellVM then put it back to datastucture type
    var onCommit : (Task) -> (Void) = { _ in }
    var body: some View {
        HStack {
            //CompeletionStateIconName
            // if statement to check if it completed or not
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
            //when user tap on image it change 
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
                }
            TextField("Enter Task Title", text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task)
            })
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}


