//
//  NetworkErrors.swift
//  UserListWithAPIExample
//
//  Created by Manoj Reddy on 12/22/25.
//

enum NetworkErrors: Error {
    case invalidURL
    case invalidResponse(statusCode:Int, message:String)
    case invalidData
    case decodingFailed
}
