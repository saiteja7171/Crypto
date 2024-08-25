//
//  String.swift
//  Crypto
//
//  Created by Sai Teja Atluri on 8/20/24.
//

import Foundation
extension String {
    var removingHTMLOccurenaces: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
