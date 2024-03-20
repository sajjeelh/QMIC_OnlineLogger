//
//  DiskStorage.swift
//  Logger
//
//  Created by Sajjeel Hussain Khilji on 19/03/2024.
//

import Foundation

class DiskStorage {
    private let fileManager = FileManager.default
    private var directoryURL: URL
    
    init() {
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        directoryURL = urls[0].appendingPathComponent("MyDataModelChunks", isDirectory: true)
        
        // Create directory for chunks if it doesn't exist
        if !fileManager.fileExists(atPath: directoryURL.path) {
            do {
                try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Failed to create directory for chunks: \(error)")
            }
        }
    }
    
    func saveChunk(data: LoggerDataModel, chunkIndex: Int) {
        let fileURL = directoryURL.appendingPathComponent("chunk_\(chunkIndex).json")
        do {
            let data = try JSONEncoder().encode(data)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save chunk to disk: \(error)")
        }
    }
    
    func removeChunk(chunkIndex: Int) {
        let fileURL = directoryURL.appendingPathComponent("chunk_\(chunkIndex).json")
        guard fileManager.fileExists(atPath: fileURL.path) else { return }
        
        do {
            try fileManager.removeItem(at: fileURL)
            print("Successfully deleted chunk \(chunkIndex)")
        } catch {
            print("Failed to delete chunk \(chunkIndex): \(error)")
        }
    }
    
    func saveToDisk(data: [LoggerDataModel]) {
        var i = 0
        for loggerDataModel in data {
            saveChunk(data: loggerDataModel, chunkIndex: i)
            i += 1
        }
        
    }
    
    
    func loadDataFromDisk() -> [LoggerDataModel] {
        var allDataModels: [LoggerDataModel] = []
        
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil)
            
            for fileURL in fileURLs {
                if fileURL.pathExtension == "json" {
                    let data = try Data(contentsOf: fileURL)
                    let dataModels = try JSONDecoder().decode([LoggerDataModel].self, from: data)
                    allDataModels.append(contentsOf: dataModels)
                }
            }
        } catch {
            print("Failed to load data from disk: \(error)")
        }
        
        return allDataModels
    }
    
    // Add other methods as needed, for example, loading chunks, handling failures, etc.
}

extension DiskStorage {
    func clearData() {
        do {
            if fileManager.fileExists(atPath: directoryURL.path) {
                try fileManager.removeItem(at: directoryURL)
                print("Data successfully cleared from disk.")
            }
        } catch {
            print("Failed to clear data from disk: \(error)")
        }
    }
}
