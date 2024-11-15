//
//  main.swift
//  Megaverse
//
//  Created by Ander Goig on 15/11/24.
//

import Foundation

do {
    print("👋 Welcome to Megaverse!")

    let candidateId = "8d87846f-31de-48cf-90e9-82a24475d201"
    let networkService = MegaverseNetworkService(candidateId: candidateId)

    print("⏳ Fetching current goal...")
    let goal = try await networkService.request(MegaverseAPI.goal(for: candidateId)).goal
    print("✅ Goal fetched")

    for row in goal.enumerated() {
        for column in row.element.enumerated() {
            switch column.element {
            case .space:
                break
            case .polyanet:
                print("🪐 Creating \(column.element) at (\(row.offset), \(column.offset))...")
                try await networkService.request(MegaverseAPI.Polyanets.create(atRow: row.offset, column: column.offset))
            case .soloon(let color):
                print("🌙 Creating \(column.element) at (\(row.offset), \(column.offset))...")
                try await networkService.request(MegaverseAPI.Soloons.create(atRow: row.offset, column: column.offset, color: color))
            case .cometh(let direction):
                print("☄️ Creating \(column.element) at (\(row.offset), \(column.offset))...")
                try await networkService.request(MegaverseAPI.Comeths.create(atRow: row.offset, column: column.offset, direction: direction))
            }
        }
    }
} catch {
    print("🔴 ERROR:", error.localizedDescription)
}
