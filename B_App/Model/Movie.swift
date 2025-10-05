//
//  Movie.swift
//  B_App
//
//  Created by Bryan Meza on 05/10/25.
//

import Foundation

struct Movie: Identifiable, Decodable {
    var id = UUID()
    var title: String
    var year: String
    var url: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case url = "Poster"
    }
}
