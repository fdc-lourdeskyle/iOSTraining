//
//  ButtonSelectorView.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/20/25.
//

import Foundation
import SwiftUI

struct ButtonSelectorView: View {
    @Binding var selectedIndex: Int
    let titles: [String]

    var body: some View {
        HStack (spacing: 12) {
            ForEach(titles.indices, id: \.self) { index in
                Button(action: {
                    selectedIndex = index
                }) {
                    VStack {
                        Text(titles[index])
                            .foregroundColor(selectedIndex == index ? .orange : .gray)
                            .fontWeight(selectedIndex == index ? .semibold : .regular)
                            .multilineTextAlignment(.center)
                        Rectangle()
                            .fill(selectedIndex == index ? Color.orange : Color.clear)
                            .frame(height: 2)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
