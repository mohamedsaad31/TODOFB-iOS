//
//  TaskListViewModel.swift
//  TODOFB
//
//  Created by mohamed saad on 12/03/2023.
//

import Foundation
import Combine


class TaskListViewModel : ObservableObject {
    @Published var taskRepository = TaskRepository()
    @Published var TaskCellViewModels = [TaskCellViewModel]()
    
    private var cancellabels = Set<AnyCancellable>()
    
    init() {
        taskRepository.$tasks.map{ tasks in
            tasks.map{ task in
                TaskCellViewModel(task : task)
                
            }
        }
        .assign(to: \.TaskCellViewModels, on: self)
        .store(in: &cancellabels)
    }
    
    func addTask(task: Task){
        taskRepository.addTask(task)
//        let taskVM = TaskCellViewModel(task: task)
//        self.TaskCellViewModels.append(taskVM)
    }
}


