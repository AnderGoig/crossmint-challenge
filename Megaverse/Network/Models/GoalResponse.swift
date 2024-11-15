//
//  MegaverseGoalResponse.swift
//  Megaverse
//
//  Created by Ander Goig on 15/11/24.
//

import Foundation

struct GoalResponse {
    let goal: [[MegaverseObject]]
}

// MARK: - Decodable

extension GoalResponse: Decodable {}
