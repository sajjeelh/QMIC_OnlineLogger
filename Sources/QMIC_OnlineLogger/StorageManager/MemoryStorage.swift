//
//  MemoryStorage.swift
//  Logger
//
//  Created by Sajjeel Hussain Khilji on 19/03/2024.
//

import Foundation

extension Notification.Name {
    static let shouldPersistDataToDisk = Notification.Name(".shouldPersistDataToDisk")
}


class MemoryStorage {
    private var bufferLimit: Int = 100 // Maximum items before auto-persisting to disk
    
    private var data: [LoggerDataModel] = []
    private let queue = DispatchQueue(label: "com.yourapp.memoryStorage", attributes: .concurrent)
    
    func addData(_ dataModel: LoggerDataModel) {
        queue.async(flags: .barrier) {
            self.data.append(dataModel)
            if self.data.count >= self.bufferLimit {
                // Notify or directly call a method to persist data to disk
                NotificationCenter.default.post(name: .shouldPersistDataToDisk, object: nil)
            }
        }
    }
    
    func getAllData() -> [LoggerDataModel] {
        queue.sync {
            return data
        }
    }
    
    func removeData(forChunkIdentifiers identifiers: [String]) {
        queue.async(flags: .barrier) {
            self.data.removeAll { identifiers.contains($0.id) }
        }
    }
    
    func clearData() {
        queue.async(flags: .barrier) {
            self.data.removeAll()
        }
    }
}

