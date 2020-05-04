//
//  Task.swift
//  Laparodome
//
//  Created by Sam Wu on 3/14/20.
//  Copyright © 2020 Sam Wu. All rights reserved.
//

import Foundation

struct Task: Hashable, Codable, Identifiable {
    
    let id: Int
    let name: String
    let instructions: [String]
    let penalties: [String]
    let timeLimit: Double
    let evaluationQuestions: [EvalutationQuestion]
}
