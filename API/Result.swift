//
//  Result.swift
//  Acronym
//
//  Created by Praveen, Anand on 11/6/21.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}
