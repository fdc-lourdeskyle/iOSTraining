//
//  TagView.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/19/25.
//

import SwiftUI

struct TagView: View {
    let text: String
    let backgroundColor: Color
    let foregroundColor: Color
    let padding: EdgeInsets

    var body: some View {
        Text(text)
            .font(.caption)
            .padding(padding)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(Capsule())
    }
}


//#Preview {
//    Sample Usage
//TagView(
//    text: "Beginner",
//    backgroundColor: .blue.opacity(0.2),
//    foregroundColor: .blue,
//    padding: EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)
//)
//}
