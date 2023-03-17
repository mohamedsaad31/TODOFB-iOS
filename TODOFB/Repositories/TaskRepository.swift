//
//  TaskRepository.swift
//  TODOFB
//
//  Created by mohamed saad on 15/03/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


class TaskRepository : ObservableObject{
    
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init(){
        loadData()
        
    }
    
    func loadData(){
        let userID = Auth.auth().currentUser?.uid
        
        db.collection("tasks")
        // we will sort by createdTime
            .order(by: "createdTime")
            .whereField("userID", isEqualTo: userID)
            .addSnapshotListener{(QuerySnapshot , error) in
                // if QuerySnapshot is not nil
                if let QuerySnapshot = QuerySnapshot{
                    // get all documents that has fetched and
                    self.tasks =  QuerySnapshot.documents.compactMap { document in
                        do {
                            let x = try?  document.data(as: Task.self)
                            return x
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                        return nil
                    }
                }
            }
    }
    func addTask(_ task : Task){
        do{
            var addedTask = task
            let userID = Auth.auth().currentUser?.uid
            addedTask.userID = userID
            let _ = try db.collection("tasks").addDocument(from: addedTask)
            
        } catch {
            fatalError("Unable to encode task: \(error)")
            
        }
    }
    func updateTask(_ task : Task){
        if let taskID = task.id{
            do{
                try db.collection("tasks").document(taskID).setData(from: task)
            } catch {
                fatalError("Unable to encode task: \(error)")
                
            }
        }
    }
}
