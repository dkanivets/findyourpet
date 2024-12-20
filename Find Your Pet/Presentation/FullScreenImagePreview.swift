//
//  FullScreenImagePreview.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import SwiftUI
import Kingfisher

struct FullScreenImageView: View {
    let image: PetImageEntity
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation { isPresented = false }
                }

            VStack(spacing: 20) {
                KFImage(URL(string: image.url ?? ""))
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .cornerRadius(10)

                VStack(alignment: .leading, spacing: 10) {
//                    if let breed = image.breeds?.first {
//                        Text("Breed: \(breed.name)")
//                            .font(.title)
//                            .foregroundColor(.white)
//                    }

                    Text("Image ID: \(image.id ?? "N/A")")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))

//                    if let breed = image.breeds?.first {
//                        Text("Temperament: \(breed.temperament ?? "Unknown")")
//                            .font(.body)
//                            .foregroundColor(.white.opacity(0.8))
//                    }
                }
                .padding()

                Spacer()
            }
            .padding()
        }
    }
}
