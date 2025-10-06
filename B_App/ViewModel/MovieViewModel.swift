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
    // Lista de películas obtenidas de la API
    var movies: [APIMovie] = []

    /// Obtiene una lista de películas de Batman desde la API de OMDb.
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

    // Obtiene los detalles de una película específica usando su IMDb ID.
    // Parameter imdbID: Identificador único de la película en IMDb.
    // Returns: Un objeto `APIMovie` con la información detallada
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
