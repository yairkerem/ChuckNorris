//
//  ChuckResponse.swift
//  ChuckHW
//
//  Created by Guy Cohen on 27/06/2022.
//

import Foundation

struct Joke: Decodable {
    let id: String
    let value: String
    var rank: Int? = 0
}
