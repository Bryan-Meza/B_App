//
//  MovieView.swift
//  B_App
//
//  Created by Bryan Meza on 05/10/25.
//

import SwiftUI

struct MovieView: View {
    @State var movieVM = MovieViewModel()
    private let cols = [GridItem(.adaptive(minimum: 120), spacing: 16)]

    var body: some View {
        ScrollView {
            Text("Batman Movies")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom,-5)
            LazyVGrid(columns: cols, spacing: 16) {
                ForEach(movieVM.movies) { movie in
                    NavigationLink(value: movie) {
                        ZStack(alignment: .bottomLeading) {
                            // Poster
                            AsyncImage(url: URL(string: movie.poster)) { img in
                                img.resizable()
                            } placeholder: {
                                Rectangle().opacity(0.1)
                            }
                            .aspectRatio(2/3, contentMode: .fit)
                            .cornerRadius(12)
                            .shadow(radius: 4)

                            // Bottom fade
                            LinearGradient(colors: [.clear, .black.opacity(0.7)],
                                           startPoint: .center, endPoint: .bottom)
                                .cornerRadius(12)
                                .allowsHitTesting(false)

                            // Title + year
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
        .task { await movieVM.getMovies() }
        .refreshable { await movieVM.getMovies() }
    }
}

#Preview { NavigationStack { MovieView() } }
