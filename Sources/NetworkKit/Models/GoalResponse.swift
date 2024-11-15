//
//  MegaverseGoalResponse.swift
//  Megaverse
//
//  Created by Ander Goig on 15/11/24.
//

import Foundation

public struct GoalResponse {
    public let goal: [[MegaverseObject]]

    public init(goal: [[MegaverseObject]]) {
        self.goal = goal
    }
}

// MARK: - Decodable

extension GoalResponse: Decodable {}
