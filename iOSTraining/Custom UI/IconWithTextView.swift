//
//  IconWithTextView.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/19/25.
//

import SwiftUI

import Kingfisher

struct CountryDetailView: View {
    let imageUrl: String
    let label: String

    var body: some View {
        HStack(spacing: 6) {
            KFImage(URL(string: imageUrl))
                .resizable()
                .frame(width: 18, height: 14)
                .cornerRadius(2) // optional: smooth edges
            Text(label)
                .font(.subheadline)
        }
        .foregroundColor(.primary)
    }
}

struct IconWithTextView: View {
    let systemImageName: String // or use asset name
    let label: String

    var body: some View {
        HStack(spacing: 6) {
            Image(systemImageName) // Or Image("assetName")
                .resizable()
                .frame(width: 18, height: 18)
            Text(label)
                .font(.subheadline)
        }
        .foregroundColor(.primary)
    }
}

struct IconAboveLabelView: View {
    let imageName: String
    let label: String
    let useSystemImage: Bool
    let iconSize: CGFloat
    let spacing: CGFloat
    let foregroundColor: Color
    let onTap: (() -> Void)?

    var body: some View {
        VStack(spacing: spacing) {
            if useSystemImage {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(foregroundColor)
            } else {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(foregroundColor)
            }

            Text(label)
                .font(.footnote)
                .multilineTextAlignment(.center)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap?()
        }
    }
}


//#Preview {
//    Sample Usage
// IconWithTextView(systemImageName: "star.fill", label: "Top Rated")
// Image("customAssetName") // instead of systemName
//}
