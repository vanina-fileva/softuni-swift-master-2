//
//  StorageManager.swift
//  ChuckNorrisJokes
//
//  Created by Vanina Fileva on 25.10.20.
//

import Foundation

protocol DataPersisting {
    var jokes: [String] { get set }
}

class StorageManager {
    
    static var shared = StorageManager()
    
    private init() {
        
    }
}
extension StorageManager: DataPersisting {
    

    var jokes: [String] {
        get {
            UserDefaults.standard.value(forKey: "jokes") as? [String] ?? []

        }
        set {
            UserDefaults.standard.set(newValue, forKey: "jokes")
        }
    }
}
