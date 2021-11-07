//
//  Acronyms.swift
//  Acronym
//
//  Created by Praveen, Anand on 11/6/21.
//

import Foundation

struct Acronyms: Codable {
    let sf: String
    let lfs: [Lfs]
}

struct Lfs: Codable {
    let lf: String
    let freq: Int
    let since: Int
    let vars: [Vars]
}

struct Vars: Codable {
    let lf: String
    let freq: Int
    let since: Int
}
