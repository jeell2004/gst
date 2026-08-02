//
//  HomeView.swift
//  PracticeDemo
//
//  Created by KMSOFT on 14/05/26.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var ViewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(alignment: .center) {
                Text("Home")
                    .font(.headline)
                    .foregroundStyle(.black)
            }
            
            VStack {
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(
                            Dictionary(grouping: ViewModel.posts, by: { $0.userId })
                                .sorted(by: { $0.key < $1.key })
                                .compactMap { $0.value.first },
                            id: \.id
                        ) { item in
                            
                            HomeCell(
                                userID: item.userId,
                                title: item.title,
                                bodyText: item.body,
                                postID: item.id
                            )
                            .onTapGesture {
                                self.router.navigate(
                                    to: .detailView(userID: item.userId)
                                )
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            ViewModel.GetData()
        }
        .navigationDestination(for: Router.Destination.self) { destination in
            self.getDestination(destination: destination)
        }
    }
    
    @ViewBuilder
    func getDestination(destination: Router.Destination) -> some View {
        
        switch destination {
            
        case .detailView(let userID):
            DetailView(userID: userID)
        }
    }
}
