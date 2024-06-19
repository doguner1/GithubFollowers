//
//  WebView.swift
//  GithubFollowers
//
//  Created by qwerty on 19.06.2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let html: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.loadHTMLString(html, baseURL: nil)
    }
}
