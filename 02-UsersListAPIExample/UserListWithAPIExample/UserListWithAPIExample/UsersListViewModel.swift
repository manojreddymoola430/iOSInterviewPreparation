//
//  UsersListViewModel.swift
//  UserListWithAPIExample
//
//  Created by Manoj Reddy on 12/22/25.
//
import SwiftUI
import Combine

@MainActor
class UsersListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var errorMessage:String? = nil
    @Published var showAlert: Bool = false
    @Published var showUsersList: Bool = true
    
    func getListofUsers() {
        let url = "https://api.github.com/users"
        NetworkManager.shared.fetchUsers([User].self, url: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let usersList):
                    self?.showUsersList = true
                    self?.users = usersList   // triggers UI refresh
                case .failure(let error):
                    print("Error:", error)
                }
            }
        }
    }
    
    func getFollowersList() async
    {
        let url = "https://api.github.com/users/mojombo/followers"
        do
        {
            let followers = try await NetworkManager.shared.fetchFollwersList([User].self, url: url)
            self.users = followers
            self.showAlert = false
            self.showUsersList = false
        }catch(let error as NetworkErrors)
        {
            switch error {
            case .invalidResponse(let code, let message):
                self.errorMessage = "Error \(code): \(message)"
                
            case .invalidURL:
                break
            case .invalidData:
                break
            case .decodingFailed:
                break
            }
            showAlert = true
        }catch
        {
            
        }
    }
}
