//
//  TODOFBApp.swift
//  TODOFB
//
//  Created by mohamed saad on 09/03/2023.
//

import SwiftUI
import Firebase

@main
struct TODOFBApp: App {
    init() {
        FirebaseApp.configure()
        if Auth.auth().currentUser == nil{
            Auth.auth().signInAnonymously()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
    }
}


