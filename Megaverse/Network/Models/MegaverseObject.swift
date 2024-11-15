//
//  MegaverseObject.swift
//  Megaverse
//
//  Created by Ander Goig on 15/11/24.
//

import Foundation

enum MegaverseObject: CustomStringConvertible {
    case space
    case polyanet
    case cometh(direction: String)
    case soloon(color: String)

    var description: String {
        switch self {
        case .space: return "SPACE"
        case .polyanet: return "POLYANET"
        case .cometh(let direction): return "\(direction)_COMETH".uppercased()
        case .soloon(let color): return "\(color)_SOLOON".uppercased()
        }
    }
}

// MARK: - Decodable

extension MegaverseObject: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let object = try container.decode(String.self)
        let components = object.split(separator: "_")
        switch (components.first, components.last) {
        case (_, "SPACE"):
            self = .space
        case (_, "POLYANET"):
            self = .polyanet
        case (.some(let direction), "COMETH"):
            self = .cometh(direction: direction.lowercased())
        case (.some(let color), "SOLOON"):
            self = .soloon(color: color.lowercased())
        default:
            throw DecodingError.typeMismatch(MegaverseObject.self, .init(codingPath: decoder.codingPath, debugDescription: "Unknown object type: \(object)"))
        }
    }
}
