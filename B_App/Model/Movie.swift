//
//  Movie.swift
//  B_App
//
//  Created by Bryan Meza on 05/10/25.
//

import Foundation

struct APIMovie: Decodable, Identifiable, Hashable {
    // Básicos
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String

    // Detalle
    let rated: String?
    let released: String?
    let runtime: String?
    let genre: String?
    let director: String?
    let writer: String?
    let actors: String?
    let plot: String?
    let language: String?
    let country: String?
    let awards: String?
    let imdbRating: String?

    var id: String { imdbID }

    enum CodingKeys: String, CodingKey {
        // básicos
        case title = "Title"
        case year  = "Year"
        case imdbID
        case type  = "Type"
        case poster = "Poster"
        // detalle
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case imdbRating
    }
    
    init(
            title: String,
            year: String,
            imdbID: String,
            type: String,
            poster: String,
            rated: String? = nil,
            released: String? = nil,
            runtime: String? = nil,
            genre: String? = nil,
            director: String? = nil,
            writer: String? = nil,
            actors: String? = nil,
            plot: String? = nil,
            language: String? = nil,
            country: String? = nil,
            awards: String? = nil,
            imdbRating: String? = nil
        ) {
            self.title = title
            self.year = year
            self.imdbID = imdbID
            self.type = type
            self.poster = poster
            self.rated = rated
            self.released = released
            self.runtime = runtime
            self.genre = genre
            self.director = director
            self.writer = writer
            self.actors = actors
            self.plot = plot
            self.language = language
            self.country = country
            self.awards = awards
            self.imdbRating = imdbRating
        }
}

// Wrapper para la búsqueda (root con Search:[...])
struct MovieResponse: Decodable {
    let Search: [APIMovie]
}

