//
//  DogViewModel.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import Combine
import Foundation

class DogViewModel: BaseViewModel {
    private let fetchDogImagesUseCase: FetchDogImagesUseCase
    private let fetchSingleDogImageUseCase: FetchSingleDogImageUseCase

    @Published var selectedImageDetails: PetImageEntity? = nil
    private var cancellables = Set<AnyCancellable>()

    init(fetchDogImagesUseCase: FetchDogImagesUseCase, fetchSingleDogImageUseCase: FetchSingleDogImageUseCase) {
        self.fetchDogImagesUseCase = fetchDogImagesUseCase
        self.fetchSingleDogImageUseCase = fetchSingleDogImageUseCase
        super.init()
        fetchRandomImages()
    }

    override func fetchImages(limit: Int, breedID: String?, page: Int) -> AnyPublisher<[PetImageEntity], NetworkError> {
        fetchDogImagesUseCase.call(limit: limit, breedID: breedID, page: page, order: "ASC")
    }

    func fetchDetails(for imageID: String) {
        isLoading = true
        fetchSingleDogImageUseCase.call(imageID: imageID)
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
