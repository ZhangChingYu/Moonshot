//
//  Mission.swift
//  Moonshot
//
//  Created by Sunny on 2024/7/30.
//

import Foundation

struct Mission {
    // nested struct to make code more organized
    struct CrewRole {
        let name: String
        let role: String
    }
    let id: Int
    let launchDate: String?
    let crews: [CrewRole]
    let description: String
}
