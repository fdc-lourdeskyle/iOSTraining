//
//  ImageButton.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/20/25.
//

import SwiftUI

struct ImageButton: View {
    let imageName: String
    let title: String?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)

                if let title = title {
                    Text(title)
                        .font(.headline)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(8)
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
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .foregroundColor(.white)
            .background(viewModel.isReserved ? Color.orange : Color.blue)
            .cornerRadius(8)
        }
    }
}
