//
//  ContentView.swift
//  B_App
//
//  Created by Bryan Meza on 05/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            MovieView()
                .navigationDestination(for: APIMovie.self) { movie in
                    MovieDetailView(movie: movie)
                }
        }
    }
}

#Preview { ContentView() }
