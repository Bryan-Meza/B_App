//
//  MovieViewModel.swift
//  B_App
//
//  Created by Bryan Meza on 05/10/25.
//

import Foundation
import Observation

struct MovieResponse: Decodable {
    let Search: [APIMovie]
}

struct APIMovie: Decodable, Identifiable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String

    var id: String { imdbID }

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year  = "Year"
        case imdbID
        case type  = "Type"
        case poster = "Poster"
    }
}

@MainActor
@Observable
class MovieViewModel {
    var movies: [APIMovie] = []

    func getMovies() async {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=d1652e56&s=batman&type=movie&page=1") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
            movies = decoded.Search
        } catch {
            print("Error:", error)
        }
    }
}

