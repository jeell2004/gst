//
//  URL.swift
//  AlvisApp
//
//  Created by kmsoft on 08/05/26.
//

import Foundation

extension URL {
    var isRemoteURL: Bool {
        return self.path().hasPrefix("http://") || self.path().hasPrefix("https://")
    }
}
