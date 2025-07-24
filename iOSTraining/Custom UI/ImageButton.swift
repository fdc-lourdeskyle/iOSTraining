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

struct ReserveButtonView: View {
    @ObservedObject var viewModel: TeacherViewModel

    var body: some View {
        Button(action: {
            print("Reserve tapped")
            viewModel.reserveTeacher()
        }) {
            HStack {
                Image("calendar 1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)

                Text(viewModel.isReserved ? "Reserved" : "Reserve")
                    .font(.system(size: 10))
                    .bold()
            }
            .padding(8)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(viewModel.isReserved ? Color.orange : Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(viewModel.isReserved ? Color.black : Color.white, lineWidth: 1)
            )
            .cornerRadius(8)
        }
    }
}
