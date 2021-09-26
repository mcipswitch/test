//
//  SWRootResponse.swift
//  swapi-ios
//
//  Created by Priscilla Ip on 2021-09-26.
//

import Foundation

struct SWRootResponse: Decodable {
    var count: Int
    var next: URL?
    var previous: URL?
    var results: [SWCharacter]
}
