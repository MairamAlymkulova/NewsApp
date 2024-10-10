//
//  NetworkManager.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//

import Foundation

class NetworkManager{
    static let shared = NetworkManager()
    
    func getData (url: String) async throws -> Data {
        guard let url = URL(string: url) else {
           throw NetworkError.wrongURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
            
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFaild
        }
        return data
    }
    
    func get <T: Decodable> (url: String) async throws -> T {
        
        let data = try await getData(url: url)
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        }
        catch {
            throw NetworkError.decodingFaild
        }
    }
    
}
