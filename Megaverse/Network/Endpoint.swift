//
//  Endpoint.swift
//  Megaverse
//
//  Created by Ander Goig on 15/11/24.
//

import Foundation

final class Endpoint<Response> {
    // MARK: - Types

    enum Method: String {
        case get, post, delete
    }

    typealias Parameters = [String: Any]
    typealias Headers = [String: String]

    // MARK: - Properties

    let method: Method
    let path: String
    let parameters: Parameters?
    let headers: Headers?
    let decode: (Data) throws -> Response

    // MARK: - Init

    init(
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

extension Endpoint where Response: Decodable {
    convenience init(method: Method = .get, path: String, parameters: Parameters? = nil, headers: Headers? = nil) {
        self.init(method: method, path: path, parameters: parameters, headers: headers) {
            try JSONDecoder().decode(Response.self, from: $0)
        }
    }
}

extension Endpoint where Response == Void {
    convenience init(method: Method = .get, path: String, parameters: Parameters? = nil, headers: Headers? = nil) {
        self.init(method: method, path: path, parameters: parameters, headers: headers) { _ in () }
    }
}
