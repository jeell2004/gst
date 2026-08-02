//
//  DetailView.swift
//  PracticeDemo
//
//  Created by KMSOFT on 14/05/26.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var ViewModel: HomeViewModel
    var userID: Int
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(
                        ViewModel.posts.filter { $0.userId == userID },
                        id: \.id
                    ) { item in
                        
                        HomeCell(
                            userID: item.userId,
                            title: item.title,
                            bodyText: item.body,
                            postID: item.id
                        )
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("User \(userID)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(userID: 1)
        .environmentObject(HomeViewModel())
}
