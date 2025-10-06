//
//  MovieViewModel.swift
//  B_App
//
//  Created by Bryan Meza on 05/10/25.
//

import Foundation
import Observation

@MainActor
@Observable
class MovieViewModel {
    var movies: [APIMovie] = []

    // Cargar la lista general
    func getMovies() async {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=d1652e56&s=batman&type=movie&page=2") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
            movies = decoded.Search
        } catch {
            print("Error:", error)
        }
    }

    // Obtener detalle de la película usando el mismo modelo
    func getMovieDetail(by imdbID: String) async -> APIMovie? {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=d1652e56&i=\(imdbID)&plot=full") else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let detailedMovie = try JSONDecoder().decode(APIMovie.self, from: data)
            return detailedMovie
        } catch {
            print("Error al obtener detalle:", error)
            return nil
        }
    }
}

