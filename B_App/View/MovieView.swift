//
//  MovieView.swift
//  B_App
//
//  Created by Bryan Meza on 05/10/25.
//

import SwiftUI

struct MovieView: View {
    // ViewModel principal que maneja la lógica y datos de las películas
    @State var movieVM = MovieViewModel()
    
    // Configuración del diseño de la cuadrícula
    private let cols = [GridItem(.adaptive(minimum: 120), spacing: 16)]

    var body: some View {
        ScrollView {
            // Título principal
            Text("Batman Movies")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, -5)
            
            // Cuadrícula con las películas
            LazyVGrid(columns: cols, spacing: 16) {
                ForEach(movieVM.movies) { movie in
                    // Navegación al detalle de la película
                    NavigationLink(value: movie) {
                        ZStack(alignment: .bottomLeading) {
                            // Imagen del póster
                            AsyncImage(url: URL(string: movie.poster)) { img in
                                img.resizable()
                            } placeholder: {
                                Rectangle().opacity(0.1)
                            }
                            .aspectRatio(2/3, contentMode: .fit)
                            .cornerRadius(12)
                            .shadow(radius: 4)

                            // Efecto de degradado en la parte inferior
                            LinearGradient(colors: [.clear, .black.opacity(0.7)],
                                           startPoint: .center, endPoint: .bottom)
                                .cornerRadius(12)
                                .allowsHitTesting(false)

                            // Título y año de la película
                            VStack(alignment: .leading, spacing: 2) {
                                Text(movie.title)
                                    .font(.caption.weight(.semibold))
                                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.9)
                                
                                Text(movie.year)
                                    .font(.caption2)
                                    .foregroundColor(.white.opacity(0.85))
                            }
                            .padding(.horizontal, 8)
                            .padding(.bottom, 10)
                        }
                    }
                }
            }
            .padding(16)
        }
        // Cargar las películas al iniciar
        .task { await movieVM.getMovies() }
        
        // Permitir actualizar con "pull-to-refresh"
        .refreshable { await movieVM.getMovies() }
    }
}

#Preview {
    NavigationStack {
        MovieView()
    }
}
