//
//  TaskCellViewModel.swift
//  TODOFB
//
//  Created by mohamed saad on 11/03/2023.
//

import Foundation
import Combine

class TaskCellViewModel : ObservableObject , Identifiable {
    @Published var task : Task
    @Published var taskRepository = TaskRepository()
    var id = ""
    @Published var CompeletionStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(task: Task){
        self.task = task
        
        $task
            .map{ task in
                task.completed ? "checkmark.circle.fill" : "circle"
                
            }
        //assign the result of map operation to CompeletionStateIconName property using combine
            .assign(to: \.CompeletionStateIconName , on: self)
            .store(in: &cancellables)
        
        $task
            .compactMap{ task in
                task.id
                
            }
        //assign the result of map operation to CompeletionStateIconName property using combine
            .assign(to: \.id , on: self)
            .store(in: &cancellables)
        
        // Any time there is a change or Edit it will updated
        $task
            .dropFirst()
        // we want to send the update only when stop typing
            .debounce(for: 0.9, scheduler: RunLoop.main)
            .sink{ task in
                self.taskRepository.updateTask(task)
            }
            .store(in: &cancellables)
        
        
        
    }
}
