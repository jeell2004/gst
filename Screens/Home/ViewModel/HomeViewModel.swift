//
//  HomeViewModel.swift
//  PracticeDemo
//
//  Created by KMSOFT on 14/05/26.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    func GetData() {
        var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler:  { data, response, error -> Void in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode([Post].self, from: data!)
                
                DispatchQueue.main.async {
                    self.posts = responseModel
                }
                
            } catch {
                print("JSON Serialization error")
            }
        }).resume()
    }
}
