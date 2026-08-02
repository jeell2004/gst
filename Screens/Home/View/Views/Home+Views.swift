//
//  Home+Views.swift
//  PracticeDemo
//
//  Created by KMSOFT on 14/05/26.
//

import Foundation
import SwiftUI

struct HomeCell : View {
    var userID: Int
    var title: String
    var bodyText: String
    var postID: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("User ID:")
                    .font(.headline)
                
                Text("\(self.userID)")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(self.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                
                Text(self.bodyText)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            
            Divider()
            
            HStack {
                Text("Post ID: \(self.postID)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 20) {
            
            HomeCell(
                userID: 10,
                title: "qui qui voluptates illo iste minima",
                bodyText: """
                earum voluptatem facere provident blanditiis velit laboriosam
                pariatur accusamus odio saepe
                cumque dolor qui a dicta ab doloribus consequatur omnis
                corporis cupiditate eaque assumenda ad nesciunt
                """,
                postID: 1
            )
            
            HomeCell(
                userID: 15,
                title: "SwiftUI Dynamic Cell",
                bodyText: "This is dynamic data without using model.",
                postID: 2
            )
        }
        .padding(.vertical)
    }
}
