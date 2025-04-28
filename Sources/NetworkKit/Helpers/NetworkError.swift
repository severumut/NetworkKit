//
//  NetworkError.swift
//  NetworkKit
//
//  Created by Umut Sever on 28.04.2025.
//

import Foundation

public struct NetworkError: Error {
    public let type: NetworkErrorType
    public let message: String
    
    public init(type: NetworkErrorType, message: String) {
        self.type = type
        self.message = message
    }
}

public enum NetworkErrorType: Int, Sendable {
    /// - badRequest: The server cannot or will not process the request due to an apparent client error.
    case badRequest = 400
    
    /// - unauthorized: Similar to 403 Forbidden, but specifically for use when authentication is required and has failed or has not yet been provided.
    case unauthorized = 401
    
    /// - forbidden: The request was a valid request, but the server is refusing to respond to it.
    case forbidden = 403
    
    /// - notFound: The requested resource could not be found but may be available in the future.
    case notFound = 404
    
    /// - methodNotAllowed: A request method is not supported for the requested resource. e.g. a GET request on a form which requires data to be presented via POST
    case methodNotAllowed = 405
    
    /// - notAcceptable: The requested resource is capable of generating only content not acceptable according to the Accept headers sent in the request.
    case notAcceptable = 406
    
    /// - requestTimeout: The server timed out waiting for the request.
    case requestTimeout = 408
    
    /// - noResponse: Used to indicate that the server has returned no information to the client and closed the connection.
    case noResponse = 444
    
    /// - internalServerError: A generic error message, given when an unexpected condition was encountered and no more specific message is suitable.
    case internalServerError = 500
    
    /// - notImplemented: The server either does not recognize the request method, or it lacks the ability to fulfill the request.
    case notImplemented = 501
    
    /// - badGateway: The server was acting as a gateway or proxy and received an invalid response from the upstream server.
    case badGateway = 502
    
    /// - serviceUnavailable: The server is currently unavailable (because it is overloaded or down for maintenance). Generally, this is a temporary state.
    case serviceUnavailable = 503
    
    /// - gatewayTimeout: The server was acting as a gateway or proxy and did not receive a timely response from the upstream server.
    case gatewayTimeout = 504
    
    /// - HTTPVersionNotSupported: The server does not support the HTTP protocol version used in the request.
    case HTTPVersionNotSupported = 505
    
    /// - variantAlsoNegotiates: Transparent content negotiation for the request results in a circular reference.
    case variantAlsoNegotiates = 506
    
    /// - insufficientStorage: The server is unable to store the representation needed to complete the request.
    case insufficientStorage = 507
    
    /// - loopDetected: The server detected an infinite loop while processing the request.
    case loopDetected = 508
    
    /// - notExtended: Further extensions to the request are required for the server to fulfill it.
    case notExtended = 510
    
    /// - networkAuthenticationRequired: The client needs to authenticate to gain network access.
    case networkAuthenticationRequired = 511
    
    case decodingFailed
    
    case unknown
}

// MARK: - DecodingErrorHandling
extension NetworkError {
    static func handleDecodingError(error: DecodingError) -> NetworkError {
        switch error {
        case .typeMismatch(let type, let context):
            debugPrint("Type \(type) mismatch: \(context.debugDescription)")
            debugPrint("codingPath: \(context.codingPath)")
            
        case .valueNotFound(_, let context):
            debugPrint("Value Not Found: \(context.debugDescription)")
            
        case .keyNotFound(let codingKey, let context):
            debugPrint("Coding Key Not Found: \(context.debugDescription)")
            debugPrint("codingKey: \(codingKey)")
            
        case .dataCorrupted(let context):
            debugPrint("Data Corrupted: \(context.debugDescription)")
            debugPrint("underlyingError: \(String(describing: context.underlyingError))")
            
        default:
            debugPrint("Unknown Error: \(error.localizedDescription)")
        }
        
        return NetworkError(type: .decodingFailed, message: error.localizedDescription)
    }
}
