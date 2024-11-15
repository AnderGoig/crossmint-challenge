//
//  NetworkService.swift
//  Megaverse
//
//  Created by Ander Goig on 15/11/24.
//

import Foundation

protocol NetworkService {
    func request<Response>(_ endpoint: Endpoint<Response>) async throws -> Response
}

// MARK: - Megaverse

actor MegaverseNetworkService: NetworkService {
    let baseURL: URL
    let candidateId: String
    let session = URLSession.shared

    init(baseURL: URL = MegaverseAPI.baseURL, candidateId: String) {
        self.baseURL = baseURL
        self.candidateId = candidateId
    }

    func request<Response>(_ endpoint: Endpoint<Response>) async throws -> Response {
        var request = URLRequest(url: baseURL.appending(path: endpoint.path))
        request.httpMethod = endpoint.method.rawValue.uppercased()
        request.allHTTPHeaderFields = endpoint.headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        var parameters = endpoint.parameters
        parameters?["candidateId"] = candidateId
        request.httpBody = try parameters.map { try JSONSerialization.data(withJSONObject: $0) }

        let (data, response) = try await session.data(for: request)

        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse()
        }

        guard response.statusCode == 200 else {
            throw NetworkError.invalidResponse(statusCode: response.statusCode)
        }

        return try endpoint.decode(data)
    }
}