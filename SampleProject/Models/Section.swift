//
//  Section.swift
//  SampleProject
//
//  Created by Manish Tard on 28/09/20.
//  Copyright © 2020 Manish Tard. All rights reserved.
//

import Foundation


struct Section: Decodable, Hashable {
    let id: Int
    let type: String
    let title: String
    let subtitle: String
    let items: [App]
}


struct App: Decodable, Hashable {
    let id: Int
    let tagline: String
    let name: String
    let subheading: String
    let image: String
    let iap: Bool
}
