// source: https://jsonplaceholder.typicode.com/posts
// single user's posts https://jsonplaceholder.typicode.com/users/1/posts

import Foundation

struct Post: Codable, Identifiable {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}
