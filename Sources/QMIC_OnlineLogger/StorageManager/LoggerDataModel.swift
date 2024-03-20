//
//  LoggerDataModel.swift
//  Logger
//
//  Created by Sajjeel Hussain Khilji on 19/03/2024.
//

import Foundation
 
public class LoggerDataModel : Codable {
    var id: String
    var timestamp: Date
    var data: Data // Ensure this can be encoded/decoded properly.
    
    public init(id: String, timestamp: Date, data: Data) {
        self.id = id
        self.timestamp = timestamp
        self.data = data
    }
}
