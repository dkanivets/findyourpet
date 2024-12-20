//
//  DogView.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import SwiftUI

struct DogView: View {
    @ObservedObject var viewModel: DogViewModel

    // Default size for the image grid
    let imageHeight: CGFloat = 150
    
    var body: some View {
        VStack {
            // Search Bar
            TextField("Search by breed", text: $viewModel.searchText, onCommit: {
                viewModel.searchByBreed()
            })
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding()

            // Image Grid
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                    ForEach(viewModel.images, id: \.id) { image in
                        AsyncImage(url: URL(string: image.url ?? "")) { phase in
                            switch phase {
                            case .empty:
                                // Placeholder while loading
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: imageHeight)
                                    .cornerRadius(10)
                            case .success(let image):
                                // Display the actual image
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: imageHeight)
                                    .clipped()
                                    .cornerRadius(10)
                            case .failure:
                                // Show error placeholder
                                Rectangle()
                                    .fill(Color.red.opacity(0.3))
                                    .frame(height: imageHeight)
                                    .cornerRadius(10)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
                .padding()
                
                // Pagination Trigger
                if viewModel.isLoading {
                    ProgressView("Loading more...")
                        .frame(height: 50)
                } else {
                    Color.clear
                        .frame(height: 50)
                        .onAppear {
                            viewModel.loadMoreImages()
                        }
                }
            }
        }
    }
}
