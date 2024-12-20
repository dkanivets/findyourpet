//
//  Injector.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 18.12.2024.
//

import Factory

// MARK: - Dependency Container
extension Container {
    // MARK: - Remote Data Sources
    var catsRemoteDataSource: Factory<CatsRemoteDataSource> {
        Factory(self) { CatsRemoteDataSourceImpl(apiService: self.apiService()) }
    }
    
    var dogsRemoteDataSource: Factory<DogsRemoteDataSource> {
        Factory(self) { DogsRemoteDataSourceImpl(apiService: self.apiService()) }
    }
    
    // MARK: - Repositories
    var catsRepository: Factory<CatsRepository> {
        Factory(self) { CatsRepositoryImp(catsRemoteDataSource: self.catsRemoteDataSource()) }
    }
    
    var dogsRepository: Factory<DogsRepository> {
        Factory(self) { DogsRepositoryImp(dogsRemoteDataSource: self.dogsRemoteDataSource()) }
    }
    
    // MARK: - Use Cases
    var fetchCatImagesUseCase: Factory<FetchCatImagesUseCase> {
        Factory(self) { FetchCatImagesUseCaseImpl(repository: self.catsRepository()) }
    }
    
    var fetchSingleCatImageUseCase: Factory<FetchSingleCatImageUseCase> {
        Factory(self) { FetchSingleCatImageUseCaseImpl(repository: self.catsRepository()) }
    }
    
    var fetchDogImagesUseCase: Factory<FetchDogImagesUseCase> {
        Factory(self) { FetchDogImagesUseCaseImpl(repository: self.dogsRepository()) }
    }
    
    var fetchSingleDogImageUseCase: Factory<FetchSingleDogImageUseCase> {
        Factory(self) { FetchSingleDogImageUseCaseImpl(repository: self.dogsRepository()) }
    }
    
    // MARK: - ViewModels
    var catViewModel: Factory<CatViewModel> {
        Factory(self) {
            CatViewModel(
                fetchCatImagesUseCase: self.fetchCatImagesUseCase()
            )
        }
    }
    
    var dogViewModel: Factory<DogViewModel> {
        Factory(self) {
            DogViewModel(
                fetchDogImagesUseCase: self.fetchDogImagesUseCase()
            )
        }
    }
    
    // MARK: - ApiService
    var apiService: Factory<ApiService> {
        Factory(self) { ApiServiceImp() }
    }
}
