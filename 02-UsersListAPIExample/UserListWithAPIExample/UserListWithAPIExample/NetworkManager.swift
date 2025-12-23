//
//  NetworkManager.swift
//  UserListWithAPIExample
//
//  Created by Manoj Reddy on 12/22/25.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchUsers<T:Decodable>(_ type:T.Type, url:String, completion:@escaping (Result<T, Error>) -> Void) -> Void
    
    func fetchFollwersList<T:Decodable>(_ type:T.Type, url:String)async throws -> T
    
}

class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchUsers<T:Decodable>(_ type:T.Type, url: String, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let urlS = URL(string:url) else {
            return completion(.failure(NSError(domain: "URL is invalid", code: -1, userInfo: nil)))
        }
        var urlRequest = URLRequest(url: urlS)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let data = data else { return completion(.failure(NSError(domain: "Invalid data", code: -1, userInfo: nil)))  }
            
            let decodedData: T
            do {
                decodedData = try JSONDecoder().decode(type, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
            
        }).resume()
        
    }
    
    func fetchFollwersList<T:Decodable>(_ type: T.Type, url: String) async throws -> T {
        guard let urlS = URL(string: url) else {
            throw NetworkErrors.invalidURL
        }
        let urlRequest = URLRequest(url: urlS)
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        if let httpResponse = response as? HTTPURLResponse,  !(200...299).contains(httpResponse.statusCode) {
            let message: String?
                    if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let msg = json["message"] as? String {
                        message = msg
                    } else {
                        message = String(data: data, encoding: .utf8)
                    }
            throw NetworkErrors.invalidResponse(statusCode: httpResponse.statusCode, message: message ?? "")
            
        }
        do{
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        }catch
        {
            throw NetworkErrors.decodingFailed
        }
      
        
    }
    
}

