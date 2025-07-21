//
//  ImageButton.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/20/25.
//

import SwiftUI

struct ImageButton: View {
    let imageName: String          // Name of the system image or asset
    let title: String?             // Optional text label
    let action: () -> Void         // Button action

    var body: some View {
        Button(action: action) {
            HStack {
                Image(imageName) // You can change this to Image(imageName) for assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)

                if let title = title {
                    Text(title)
                        .font(.headline)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
        }
    }
}
