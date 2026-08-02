//
//  Utility.swift
//  GST Verify_iOS
//
//  Created by KMSOFT on 06/06/26.
//

import Foundation

class Utility {
    class func isDebug() -> Bool {
#if DEBUG
        return true
#else
        return false
#endif
    }
}
