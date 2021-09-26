//
//  Character.swift
//  swapi-ios
//
//  Created by Priscilla Ip on 2021-09-26.
//

import Foundation

struct SWCharacter: Codable, Hashable {
    var name: String
    var height: String
    var mass: String
    var hairColor: String
    var skinColor: String
    var eyeColor: String
    var birthYear: String
    var gender: String
    var films: [URL]
}
