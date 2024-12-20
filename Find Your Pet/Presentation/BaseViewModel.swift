//
//  BaseViewModel.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import SwiftUI
import Combine

class BaseViewModel: ObservableObject {
    @Published var images: [PetImageEntity] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var hasMoreData: Bool = true

    private(set) var page: Int = 1
    private var isFetchingMore: Bool = false
    private var cancellables = Set<AnyCancellable>()

    func fetchImages(limit: Int, breedID: String?, page: Int) -> AnyPublisher<[PetImageEntity], NetworkError> {
        fatalError("Subclasses must override `fetchImages`")
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
        guard !isFetchingMore && !isLoading && hasMoreData else { return }
        isFetchingMore = true
        page += 1
        loadImages()
    }

    private func resetPagination() {
        page = 1
        images.removeAll()
        hasMoreData = true
    }

    private func loadImages() {
        guard !isLoading else { return }
        isLoading = true

        fetchImages(limit: 20, breedID: searchText.isEmpty ? nil : searchText, page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                self?.isFetchingMore = false
                if case .failure = completion { self?.hasMoreData = false }
            } receiveValue: { [weak self] newImages in
                if newImages.isEmpty { self?.hasMoreData = false }
                self?.images.append(contentsOf: newImages)
                self?.isFetchingMore = false
            }
            .store(in: &cancellables)
    }
}
