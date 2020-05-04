//
//  EvaulationQuestion.swift
//  Laparodome
//
//  Created by Sam Wu on 3/14/20.
//  Copyright © 2020 Sam Wu. All rights reserved.
//

import Foundation

struct EvalutationQuestion: Hashable, Codable {
    let question: String
    let expectedValue: Bool
}
