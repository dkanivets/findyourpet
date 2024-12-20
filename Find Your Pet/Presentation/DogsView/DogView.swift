//
//  DogView.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import SwiftUI
import Factory

struct DogView: View {
    @InjectedObject(\.dogViewModel) var viewModel

    var body: some View {
        SearchablePhotoGrid(
            viewModel: viewModel,
            fetchDetails: { imageID in
                viewModel.fetchDetails(for: imageID)
            },
            selectedImageDetails: viewModel.selectedImageDetails
        )
    }
}
