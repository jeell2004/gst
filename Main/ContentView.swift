//
//  ContentView.swift
//  PracticeDemo
//
//  Created by KMSOFT on 14/05/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var router = Router()
    @StateObject var ViewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack(path: self.$router.navPath) {
            HomeView()
        }
        .environmentObject(router)
        .environmentObject(ViewModel)
    }
}

#Preview {
    ContentView()
}
