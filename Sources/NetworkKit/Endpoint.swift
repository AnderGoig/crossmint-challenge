//
//  Endpoint.swift
//  Megaverse
//
//  Created by Ander Goig on 15/11/24.
//

import Foundation

public final class Endpoint<Response> {
    // MARK: - Types

    public enum Method: String {
        case get, post, delete
    }

    public typealias Parameters = [String: Any]
    public typealias Headers = [String: String]

    // MARK: - Properties

    public let method: Method
    public let path: String
    public let parameters: Parameters?
    public let headers: Headers?
    public let decode: (Data) throws -> Response

    // MARK: - Init

    public init(
        method: Method = .get,
        path: String,
        parameters: Parameters? = nil,
        headers: Headers? = nil,
        decode: @escaping (Data) throws -> Response
    ) {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.headers = headers
        self.decode = decode
    }
}

// MARK: - Convenience

public extension Endpoint where Response: Decodable {
    convenience init(method: Method = .get, path: String, parameters: Parameters? = nil, headers: Headers? = nil) {
        self.init(method: method, path: path, parameters: parameters, headers: headers) {
            try JSONDecoder().decode(Response.self, from: $0)
        }
    }
}

public extension Endpoint where Response == Void {
    convenience init(method: Method = .get, path: String, parameters: Parameters? = nil, headers: Headers? = nil) {
        self.init(method: method, path: path, parameters: parameters, headers: headers) { _ in () }
    }
}
