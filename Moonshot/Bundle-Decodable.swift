//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Sunny on 2024/7/30.
//

import Foundation

// for json file loading

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        // throws fatal error if file not found
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        // throws fatal error if file cannot load
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        // throws fatal error if loaded data cannot decode with explainations
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context){
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context){
            fatalError("Failed to decode \(file) from bundle due to type missmatch - \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context){
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON.")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
