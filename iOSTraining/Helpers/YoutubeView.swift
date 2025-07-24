//
//  YoutubeView.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/23/25.
//

import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let embedHTML = """
        <iframe width="50%%" height="50%%" src="https://www.youtube.com/embed/\(videoID)?playsinline=1" frameborder="0" allowfullscreen></iframe>
        """
        uiView.scrollView.isScrollEnabled = false
        uiView.loadHTMLString(embedHTML, baseURL: nil)
    }
}

