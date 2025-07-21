//
//  SwiftUIView.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/19/25.
//

import SwiftUI

struct CircularURLImageView: View {
    let url: URL?
    let size: CGFloat

    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Color.gray.opacity(0.3)
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
}


//#Preview {
//    SwiftUIView()
//CircularURLImageView(url: URL(string: "https://example.com/image.jpg"), size: 50)
//}
