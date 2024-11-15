//
//  MegaverseAPI.swift
//  Megaverse
//
//  Created by Ander Goig on 15/11/24.
//

import Foundation

enum MegaverseAPI {
    // MARK: - Properties

    static let baseURL = URL(string: "https://challenge.crossmint.io/api")!

    // MARK: - Endpoints

    static func goal(for candidateId: String) -> Endpoint<GoalResponse> {
        Endpoint(path: "/map/\(candidateId)/goal")
    }

    static func createObject(_ object: String, atRow row: Int, column: Int, and extraParameters: [String: Any] = [:]) -> Endpoint<Void> {
        let parameters = ["row": row, "column": column].merging(extraParameters, uniquingKeysWith: { _, new in new })
        return Endpoint(method: .post, path: object, parameters: parameters)
    }

    static func deleteObject(_ object: String, atRow row: Int, column: Int) -> Endpoint<Void> {
        let parameters = ["row": row, "column": column]
        return Endpoint(method: .post, path: object, parameters: parameters)
    }
}

// MARK: - Polyanets

extension MegaverseAPI {
    enum Polyanets {
        static let name = "polyanets"

        static func create(atRow row: Int, column: Int) -> Endpoint<Void> {
            createObject(name, atRow: row, column: column)
        }

        static func delete(atRow row: Int, column: Int) -> Endpoint<Void> {
            deleteObject(name, atRow: row, column: column)
        }
    }
}

// MARK: - Soloons

extension MegaverseAPI {
    enum Soloons {
        static let name = "soloons"

        static func create(atRow row: Int, column: Int, color: String) -> Endpoint<Void> {
            createObject(name, atRow: row, column: column, and: ["color": color])
        }

        static func delete(atRow row: Int, column: Int) -> Endpoint<Void> {
            deleteObject(name, atRow: row, column: column)
        }
    }
}

// MARK: - Comeths

extension MegaverseAPI {
    enum Comeths {
        static let name = "comeths"

        static func create(atRow row: Int, column: Int, direction: String) -> Endpoint<Void> {
            createObject(name, atRow: row, column: column, and: ["direction": direction])
        }

        static func delete(atRow row: Int, column: Int) -> Endpoint<Void> {
            deleteObject(name, atRow: row, column: column)
        }
    }
}
