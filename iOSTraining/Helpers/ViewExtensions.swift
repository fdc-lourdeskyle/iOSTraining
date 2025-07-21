//
//  ViewExtensions.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/18/25.
//

import SwiftUI

extension View {

    /// Adds a circular border or image mask
    func circularFrame(size: CGFloat = 40) -> some View {
        self
            .frame(width: size, height: size)
            .clipShape(Circle())
    }

    /// Adds a border with corner radius and stroke color
    func roundedBorder(
        color: Color = .gray,
        cornerRadius: CGFloat = 8,
        lineWidth: CGFloat = 1
    ) -> some View {
        self
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(color, lineWidth: lineWidth)
            )
    }

    /// Tag style with pill shape
    func tagStyle(
        backgroundColor: Color = Color.gray.opacity(0.2),
        foregroundColor: Color = .primary
    ) -> some View {
        self
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(20)
    }

    /// Adds spacing to edges
    func padded(_ edges: Edge.Set = .all, _ value: CGFloat = 8) -> some View {
        self.padding(edges, value)
    }

    /// Applies a soft shadow
    func softShadow() -> some View {
        self.shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

