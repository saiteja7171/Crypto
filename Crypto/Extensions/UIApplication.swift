//
//  UIApplication.swift
//  Crypto
//
//  Created by Sai Teja Atluri on 7/28/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
