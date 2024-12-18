//
//  Injector.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 18.12.2024.
//

import Factory

extension Container {
    var catRepository: Factory<CatRepository> {
        Factory(self) { RemoteCatRepository() }
    }
    
    var fetchCatImagesUseCase: Factory<FetchCatImagesUseCase> {
        Factory(self) { FetchCatImagesUseCase(repository: self.catRepository()) }
    }
}
