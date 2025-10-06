//
//  MovieDetailView.swift
//  B_App
//
//  Created by Bryan Meza on 05/10/25.
//

import SwiftUI

struct MovieDetailView: View {
    // Película seleccionada desde la vista principal
    let movie: APIMovie
    
    // ViewModel para obtener detalles adicionales desde la API
    @State var movieVM = MovieViewModel()
    
    // Película detallada
    @State private var detailedMovie: APIMovie?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                
                // Imagen del póster
                if let url = URL(string: detailedMovie?.poster ?? movie.poster) {
                    AsyncImage(url: url) { img in
                        img.resizable()
                    } placeholder: {
                        Rectangle().opacity(0.1)
                    }
                    .aspectRatio(2/3, contentMode: .fit)
                    .cornerRadius(14)
                    .shadow(radius: 6)
                }

                // Título y año de la película
                Text("\(detailedMovie?.title ?? movie.title) (\(detailedMovie?.year ?? movie.year))")
                    .font(.title2.bold())

                // Detalles adicionales: duración, género y calificación
                HStack(spacing: 12) {
                    if let runtime = detailedMovie?.runtime {
                        Label(runtime, systemImage: "clock")
                    }
                    if let genre = detailedMovie?.genre {
                        Label(genre, systemImage: "film")
                    }
                    if let rating = detailedMovie?.imdbRating {
                        Label("\(rating)", systemImage: "star.fill")
                    }
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                // Descripción
                if let plot = detailedMovie?.plot {
                    Text(plot)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }

                // Director y elenco principal
                VStack(alignment: .leading, spacing: 6) {
                    if let director = detailedMovie?.director {
                        Text("Director: \(director)")
                    }
                    if let actors = detailedMovie?.actors {
                        Text("Cast: \(actors)")
                    }
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            .padding()
        }
        // Título de navegación (modo compacto)
        .navigationTitle(detailedMovie?.title ?? movie.title)
        .navigationBarTitleDisplayMode(.inline)
        
        // Carga asincrónica de los detalles de la película
        .task {
            if let fullDetail = await movieVM.getMovieDetail(by: movie.imdbID) {
                detailedMovie = fullDetail
            } else {
                // Si falla, usa los datos básicos
                detailedMovie = movie
            }
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: APIMovie(
            title: "Batman Begins",
            year: "2005",
            imdbID: "tt0372784",
            type: "movie",
            poster: "https://m.media-amazon.com/images/M/MV5BODIyMDdhNTgtNDlmOC00MjUxLWE2NDItODA5MTdkNzY3ZTdhXkEyXkFqcGc@._V1_SX300.jpg"
        ))
    }
}
