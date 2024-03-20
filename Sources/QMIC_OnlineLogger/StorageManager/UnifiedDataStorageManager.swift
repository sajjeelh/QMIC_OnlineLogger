//
//  UnifiedDataStorageManager.swift
//  Logger
//
//  Created by Sajjeel Hussain Khilji on 19/03/2024.
//

import Foundation

class UnifiedDataStorageManager {
    private let memoryStorage: MemoryStorage
    private let diskStorage: DiskStorage
    private let dataSyncManager: DataSyncManager
    private var chunkIndex = 0

    init() {
        self.memoryStorage = MemoryStorage()
        self.diskStorage = DiskStorage()
        self.dataSyncManager = DataSyncManager(memoryStorage: memoryStorage, diskStorage: diskStorage)
        self.dataSyncManager.startSyncing()

        // Register for the notification
        NotificationCenter.default.addObserver(self, selector: #selector(persistDataToDisk), name: .shouldPersistDataToDisk, object: nil)
    }
    
    

    func saveData(_ dataModel: LoggerDataModel) {
        // First, save data to memory.
        memoryStorage.addData(dataModel)

        // Optionally, decide based on some criteria (e.g., app state, memory usage) whether to immediately persist to disk.
        // For simplicity, this example demonstrates immediate disk storage alongside memory storage.
        // In a real application, this might be based on app-specific logic, such as app going to background, etc.
        diskStorage.saveChunk(data: dataModel, chunkIndex: chunkIndex)
//        diskStorage.saveToDisk(data: memoryStorage.getAllData())

        chunkIndex += 1
        // The actual synchronization to the server will be handled by the DataSyncManager according to its schedule.
        // This approach keeps data storage operations simple and non-blocking for the client.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension UnifiedDataStorageManager {
    

    @objc private func persistDataToDisk() {
        let data = memoryStorage.getAllData()
        diskStorage.saveToDisk(data: data)
    }

   
}
