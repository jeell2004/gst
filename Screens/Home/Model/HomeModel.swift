//
//  HomeModel.swift
//  PracticeDemo
//
//  Created by KMSOFT on 14/05/26.
//

import Foundation

// MARK: - Response Model
struct HomeResponse: Codable {
    let items: [Post]
}

// MARK: - Post Model
struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
