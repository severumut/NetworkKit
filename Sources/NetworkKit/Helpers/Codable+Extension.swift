//
//  Codable+Extension.swift
//  NetworkKit
//
//  Created by Umut Sever on 28.04.2025.
//

import Foundation

public extension Encodable {
    func data() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
