//
//  MegaverseAPI.swift
//  Megaverse
//
//  Created by Ander Goig on 15/11/24.
//

import Foundation

public enum MegaverseAPI {
    // MARK: - Properties

    public static let baseURL = URL(string: "https://challenge.crossmint.io/api")!

    // MARK: - Endpoints

    public static func goal(for candidateId: String) -> Endpoint<GoalResponse> {
        Endpoint(path: "/map/\(candidateId)/goal")
    }

    internal static func createObject(_ object: String, atRow row: Int, column: Int, and extraParameters: [String: Any] = [:]) -> Endpoint<Void> {
        let parameters = ["row": row, "column": column].merging(extraParameters, uniquingKeysWith: { _, new in new })
        return Endpoint(method: .post, path: object, parameters: parameters)
    }

    internal static func deleteObject(_ object: String, atRow row: Int, column: Int) -> Endpoint<Void> {
        let parameters = ["row": row, "column": column]
        return Endpoint(method: .post, path: object, parameters: parameters)
    }
}

// MARK: - Polyanets

public extension MegaverseAPI {
    enum Polyanets {
        private static let name = "polyanets"

        public static func create(atRow row: Int, column: Int) -> Endpoint<Void> {
            createObject(name, atRow: row, column: column)
        }

        public static func delete(atRow row: Int, column: Int) -> Endpoint<Void> {
            deleteObject(name, atRow: row, column: column)
        }
    }
}

// MARK: - Soloons

public extension MegaverseAPI {
    enum Soloons {
        private static let name = "soloons"

        public static func create(atRow row: Int, column: Int, color: String) -> Endpoint<Void> {
            createObject(name, atRow: row, column: column, and: ["color": color])
        }

        public static func delete(atRow row: Int, column: Int) -> Endpoint<Void> {
            deleteObject(name, atRow: row, column: column)
        }
    }
}

// MARK: - Comeths

public extension MegaverseAPI {
    enum Comeths {
        private static let name = "comeths"

        public static func create(atRow row: Int, column: Int, direction: String) -> Endpoint<Void> {
            createObject(name, atRow: row, column: column, and: ["direction": direction])
        }

        public static func delete(atRow row: Int, column: Int) -> Endpoint<Void> {
            deleteObject(name, atRow: row, column: column)
        }
    }
}
