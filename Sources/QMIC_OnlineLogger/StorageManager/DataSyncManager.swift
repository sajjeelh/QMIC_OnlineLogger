//
//  DataSyncManager.swift
//  Logger
//
//  Created by Sajjeel Hussain Khilji on 19/03/2024.
//

import Foundation

class DataSyncManager {
    private let memoryStorage: MemoryStorage
    private let diskStorage: DiskStorage
    private var timer: Timer?
    private var maxRetryAttempts: Int = 5
    private var retryDelay: TimeInterval = 2 // Initial delay in seconds
    private let chunkSize: Int = 50 // Number of data models per chunk
    
    private var maxSyncInterval: Int = 5 * 60 // after every 5 mintues
    
    
    init(memoryStorage: MemoryStorage, diskStorage: DiskStorage) {
        self.memoryStorage = memoryStorage
        self.diskStorage = diskStorage
    }
    
    func startSyncing(interval: TimeInterval = 300) { // Default to 5 minutes
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(maxSyncInterval), repeats: true) { [weak self] _ in
            self?.syncData()
        }
    }
    
    private func syncData() {
        let data = memoryStorage.getAllData().isEmpty ? diskStorage.loadDataFromDisk() : memoryStorage.getAllData()
        guard !data.isEmpty else { return }
        
//        sendDataToServer(data: data)
    }
     
    
//    private func sendDataToServer(data: [Data], attempt: Int = 0) {
//        // Split data into chunks
//        let chunks = data.chunked(into: chunkSize)
//        
//        for (index, chunk) in chunks.enumerated() {
//            // For each chunk, attempt to send to the server
//            
//            performChunkedRequest(with: chunk, chunkIndex: index, totalChunks: chunks.count, attempt: attempt)
//        }
//    }
//    
//    private func performChunkedRequest(with chunk: Data, chunkIndex: Int, totalChunks: Int, attempt: Int = 0) {
//        performRequest(with: chunk) { [weak self] success in
//            guard let self = self else { return }
//            
//            if success {
//                // Handle successful chunk transmission, e.g., marking the chunk as sent
//                print("Chunk \(chunkIndex + 1)/\(totalChunks) successfully sent.")
//                
////                let chunkIdentifiers = chunk.map { $0.id }
////                self.memoryStorage.removeData(forChunkIdentifiers: chunkIdentifiers)
//                self.memoryStorage.removeData(chunkIndex: chunkIndex)
//                self.diskStorage.removeChunk(chunkIndex: chunkIndex)
//
//                
//                self.handleChunkSuccess(chunkIndex: chunkIndex, totalChunks: totalChunks)
//            } else if attempt < self.maxRetryAttempts {
//                // Retry logic for individual chunks
//                let nextAttempt = attempt + 1
//                let delay = self.retryDelay * pow(2.0, Double(nextAttempt))
//                DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
//                    self.performChunkedRequest(with: chunk, chunkIndex: chunkIndex, totalChunks: totalChunks, attempt: nextAttempt)
//                }
//            } else {
//                // Handle failure after all retries
//                print("Failed to send chunk \(chunkIndex + 1)/\(totalChunks) after \(self.maxRetryAttempts) attempts.")
//                // Consider saving chunk for future retry or handling the error appropriately
//            }
//        }
//    }
//    
//    private func performRequest(with data: Data, completion: @escaping (Bool) -> Void) {
//        // Here, convert your data to the necessary format for your API request, e.g., JSON.
//        // Then, construct and execute a URLSession data task.
//        
//        let url = URL(string: " ")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        do {
////            let jsonData = try JSONEncoder().encode(data)
//            request.httpBody = data
//            
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                    completion(false)
//                    return
//                }
//                completion(true)
//            }
//            task.resume()
//        } catch {
//            print("Error preparing request: \(error)")
//            completion(false)
//        }
//    }
//    
//    
//    private func handleChunkSuccess(chunkIndex: Int, totalChunks: Int) {
//        // Implement logic to track the successful transmission of all chunks
//        // Possibly updating a shared resource with thread-safe operations
//    }
}






extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
