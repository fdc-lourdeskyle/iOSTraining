//
//  TeacherStatusIndicatorView.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/23/25.
//

import UIKit
import SwiftUI

class TeacherStatusIndicatorView: UIView {

    var status: Int = 0 {
        didSet {
            backgroundColor = color(for: status)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        layer.cornerRadius = bounds.size.width / 2
        layer.masksToBounds = true
        backgroundColor = color(for: status)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width / 2
    }

    private func color(for status: Int) -> UIColor {
        switch status {
        case 0:
            return .gray      // Not standby || logged out
        case 1:
            return .blue      // Standby or own reservation
        case 2:
            return .yellow    // Meal break, etc.
        case 3:
            return .red       // On lesson
        case 6:
            return .systemPink // Live lesson on-air
        default:
            return .lightGray // Unknown fallback
        }
    }
}

struct TeacherStatusIndicator: UIViewRepresentable {
    let status: Int

    func makeUIView(context: Context) -> TeacherStatusIndicatorView {
        let view = TeacherStatusIndicatorView()
        return view
    }

    func updateUIView(_ uiView: TeacherStatusIndicatorView, context: Context) {
        uiView.status = status
    }
}


