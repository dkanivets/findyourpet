//
//  CatViewModel.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import SwiftUI
import Combine

class CatViewModel: ObservableObject {
    private let fetchCatImagesUseCase: FetchCatImagesUseCase
    @Published var images: [PetImageEntity] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    private var isFetchingMore = false // Prevent duplicate loads

    private var page = 1
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchCatImagesUseCase: FetchCatImagesUseCase) {
        self.fetchCatImagesUseCase = fetchCatImagesUseCase
        fetchRandomImages()
    }
    
    func fetchRandomImages() {
        resetPagination()
        loadImages()
    }
    
    func searchByBreed() {
        resetPagination()
        loadImages()
    }
    
    func loadMoreImages() {
        guard !isFetchingMore && !isLoading else { return } // Prevent multiple triggers
        isFetchingMore = true
        page += 1
        loadImages()
    }
    
    private func resetPagination() {
        page = 1
        images.removeAll()
    }
    
    private func loadImages() {
        isLoading = true
        fetchCatImagesUseCase
            .call(limit: 20, breedID: searchText.isEmpty ? nil : searchText, page: page, order: "ASC")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                self?.isFetchingMore = false
            } receiveValue: { [weak self] newImages in
                self?.images.append(contentsOf: newImages)
                self?.isFetchingMore = false
            }
            .store(in: &cancellables)
    }
}
