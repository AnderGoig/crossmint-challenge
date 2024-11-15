//
//  NetworkError.swift
//  Megaverse
//
//  Created by Ander Goig on 15/11/24.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse(statusCode: Int? = nil)
}
