//
//  Task.swift
//  TODOFB
//
//  Created by mohamed saad on 09/03/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task : Codable, Identifiable {
    @DocumentID var id : String?
    var title : String
    var completed : Bool
    @ServerTimestamp var createdTime : Timestamp?
    var userID : String? 

}


#if DEBUG
let tastDataTasks = [
    Task(title: "implement the ui", completed: true),
    Task(title: "connected to firebase ", completed: false),
    Task(title: "????? ", completed: false),
    Task(title: "Profit ", completed: false)

]


#endif
