//
//  Data+HexEncodedString.swift
//  CertFinder
//
//  Created by Joel Rennich on 11/16/20.
//

import Foundation

extension Data {
    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
