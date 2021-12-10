//
//  User.swift
//  concurrency
//
//  Created by Michael McGreal on 12/8/21.
//

import Foundation

// source: https://jsonplaceholder.typicode.com/users

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
