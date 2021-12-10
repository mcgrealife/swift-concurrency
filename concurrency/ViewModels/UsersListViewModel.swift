//
//  UsersListViewModel.swift
//  concurrency
//
//  Created by Michael McGreal on 12/9/21.
//

import Foundation


class UsersListViewModel : ObservableObject {
    @Published var users: [User] = []
    
    func fetchUsers() {
     let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        apiService.getJSON { (result: Result<[User], APIError>) in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.users = users
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
