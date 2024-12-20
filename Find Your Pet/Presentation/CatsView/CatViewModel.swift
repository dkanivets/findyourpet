//
//  CatViewModel.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import Combine
import Foundation

class CatViewModel: BaseViewModel {
    private let fetchCatImagesUseCase: FetchCatImagesUseCase
    private let fetchSingleCatImageUseCase: FetchSingleCatImageUseCase

    @Published var selectedImageDetails: PetImageEntity? = nil

    private var cancellables = Set<AnyCancellable>()

    init(fetchCatImagesUseCase: FetchCatImagesUseCase, fetchSingleCatImageUseCase: FetchSingleCatImageUseCase) {
        self.fetchCatImagesUseCase = fetchCatImagesUseCase
        self.fetchSingleCatImageUseCase = fetchSingleCatImageUseCase
        super.init()
        fetchRandomImages()
    }

    override func fetchImages(limit: Int, breedID: String?, page: Int) -> AnyPublisher<[PetImageEntity], NetworkError> {
        fetchCatImagesUseCase.call(limit: limit, breedID: breedID, page: page, order: "ASC")
    }

    func fetchDetails(for imageID: String) {
        isLoading = true
        fetchSingleCatImageUseCase.call(imageID: imageID)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
            } receiveValue: { [weak self] imageDetails in
                self?.selectedImageDetails = imageDetails
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
}
