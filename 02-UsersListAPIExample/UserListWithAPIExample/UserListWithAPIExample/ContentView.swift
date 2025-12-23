//
//  ContentView.swift
//  UserListWithAPIExample
//
//  Created by Manoj Reddy on 12/22/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = UsersListViewModel()
    
    var body: some View {
        VStack {
            Toggle(isOn: $viewModel.showUsersList){
                viewModel.showUsersList == true ? Text("Users List") : Text("Follower List")
            }
            List(viewModel.users) { user in
                HStack{
                    AsyncImage(url:URL(string:user.avatar_url))
                        .frame(width: 50, height: 50)
                        .clipShape(.circle)
                    Text(user.login)
                }
            }
        }
        .onChange(of: viewModel.showUsersList) { newValue in
            if newValue {
                viewModel.getListofUsers()
            }else
            {
                Task {
                    await viewModel.getFollowersList()
                }
            }
        }
        .onAppear(){
            Task {
                await viewModel.getFollowersList()
            }
        }
        .alert(viewModel.errorMessage ?? "", isPresented: $viewModel.showAlert, actions: {
            Button("OK") {
                viewModel.showAlert = false
            }
        })
    }
}

#Preview {
    ContentView()
}
