//
//  NetworkService.swift
//  Megaverse
//
//  Created by Ander Goig on 15/11/24.
//

import Foundation

public protocol NetworkService {
    func request<Response>(_ endpoint: Endpoint<Response>) async throws -> Response
}

// MARK: - Megaverse

public actor MegaverseNetworkService: NetworkService {
    private let baseURL: URL
    private let candidateId: String
    private let session = URLSession.shared

    public init(baseURL: URL = MegaverseAPI.baseURL, candidateId: String) {
        self.baseURL = baseURL
        self.candidateId = candidateId
    }

    public func request<Response>(_ endpoint: Endpoint<Response>) async throws -> Response {
        var request = URLRequest(url: baseURL.appending(path: endpoint.path))
        request.httpMethod = endpoint.method.rawValue.uppercased()
        request.allHTTPHeaderFields = endpoint.headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        var parameters = endpoint.parameters
        parameters?["candidateId"] = candidateId
        request.httpBody = try parameters.map { try JSONSerialization.data(withJSONObject: $0) }

        while true {
            let (data, response) = try await session.data(for: request)

            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse()
            }

            if response.statusCode == 200 {
                return try endpoint.decode(data)
            }

            if response.statusCode == 429 {
                let retryAfterSeconds = response.value(forHTTPHeaderField: "Retry-After").flatMap(Double.init) ?? 2
                try await Task.sleep(for: .seconds(retryAfterSeconds))
                continue
            }

            throw NetworkError.invalidResponse(statusCode: response.statusCode)
        }
    }
}
