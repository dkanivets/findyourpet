//
//  DogViewModel.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import SwiftUI
import Combine

class DogViewModel: ObservableObject {
    private let fetchDogImagesUseCase: FetchDogImagesUseCase
    @Published var images: [PetImageEntity] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false

    private var page = 1
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchDogImagesUseCase: FetchDogImagesUseCase) {
        self.fetchDogImagesUseCase = fetchDogImagesUseCase
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
        page += 1
        loadImages()
    }
    
    private func resetPagination() {
        page = 1
        images.removeAll()
    }
    
    private func loadImages() {
        isLoading = true
        fetchDogImagesUseCase
            .call(limit: 20, breedID: searchText.isEmpty ? nil : searchText, page: page, order: "ASC")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
            } receiveValue: { [weak self] newImages in
                self?.images.append(contentsOf: newImages)
            }
            .store(in: &cancellables)
    }
}
