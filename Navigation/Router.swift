//
//  Router.swift
//  Inventory Management
//
//  Created by KMSOFT on 17/02/25.
//

import SwiftUI
import Combine

final class Router: ObservableObject {
    
    enum Destination: Hashable {
        case detailView(userID: Int)
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        self.navPath.append(destination)
    }
    
    func navigateBack() {
        if !self.navPath.isEmpty {
            self.navPath.removeLast()
        }
    }
    
    func navigateToRoot() {
        self.navPath.removeLast(self.navPath.count)
    }
}
