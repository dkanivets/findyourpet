//
//  SearchablePhotoGrid.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import SwiftUI
import Kingfisher

struct SearchablePhotoGrid: View {
    @ObservedObject var viewModel: BaseViewModel
    let fetchDetails: (String) -> Void
    let selectedImageDetails: PetImageEntity?
    let imageHeight: CGFloat = 150

    @State private var isFullScreen: Bool = false
    @State private var availableWidth: CGFloat = UIScreen.main.bounds.width

    private let spacing: CGFloat = 10

    private var columns: [GridItem] {
        let columnWidth = imageHeight
        let columnCount = max(Int(availableWidth / (columnWidth + spacing)), 1)
        return Array(repeating: GridItem(.flexible(), spacing: spacing), count: columnCount)
    }

    var body: some View {
        ZStack {
            VStack {
                TextField("Search by breed", text: $viewModel.searchText, onCommit: {
                    viewModel.searchByBreed()
                })
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)

                GeometryReader { geometry in
                    let width = geometry.size.width
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: spacing) {
                            ForEach(viewModel.images.indices, id: \.self) { index in
                                KFImage(URL(string: viewModel.images[index].url))
                                    .placeholder {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: imageHeight, height: imageHeight)
                                            .cornerRadius(10)
                                    }
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: imageHeight, height: imageHeight) // Explicit size
                                    .clipped()
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        fetchDetails(viewModel.images[index].id)
                                        isFullScreen = true
                                    }
                                    .onAppear {
                                        if index == viewModel.images.count - 1 {
                                            viewModel.loadMoreImages()
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal, spacing)
                        .onAppear {
                            availableWidth = width
                        }
                        .onChange(of: geometry.size.width) { newWidth in
                            availableWidth = newWidth
                        }
                    }
                }
                .frame(maxHeight: .infinity)

                if viewModel.isLoading {
                    ProgressView("Loading more...")
                        .padding()
                }
            }

            if isFullScreen, let imageDetails = selectedImageDetails {
                FullScreenImageView(image: imageDetails, isPresented: $isFullScreen)
                    .zIndex(1)
                    .transition(.opacity)
            }
        }
    }
}
