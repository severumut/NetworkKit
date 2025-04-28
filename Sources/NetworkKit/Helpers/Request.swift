//
//  Request.swift
//  NetworkKit
//
//  Created by Umut Sever on 28.04.2025.
//

import Foundation

public protocol Request {
    var endpoint: EndpointProtocol { get }
    var method: HTTPMethod { get }
    var header: [String: String] { get }
    var body: Encodable? { get }
}

public extension Request {
    var method: HTTPMethod {
        .GET
    }
    
    var header: [String: String] {
        [:]
    }
    
    var body: Encodable? {
        nil
    }
}

// MARK: - Build
public extension Request {
    func buildURLRequest() -> URLRequest? {
        var urlRequest = URLRequest(url: endpoint.url)
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body?.data()
        return urlRequest
    }
}
