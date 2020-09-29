//
//  WebView.swift
//  RichWebViewSample
//
//  Created by 青木孝乃輔 on 2020/09/27.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    /// WebViewのアクション
    enum Action {
        case none
        case goBack
        case goForward
        case reload
    }

    /// 表示するView
    private let webView = WKWebView()
    /// 表示するURL
    let url: URL
    /// アクション
    @Binding var action: Action
    /// 戻れるか
    @Binding var canGoBack: Bool
    /// 進めるか
    @Binding var canGoForward: Bool
    /// 読み込みの進捗状況
    @Binding var estimatedProgress: Double
    /// ローディング中かどうか
    @Binding var isLoading: Bool
    /// ページタイトル
    @Binding var pageTitle: String

    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        switch action {
        case .goBack:
            uiView.goBack()
        case .goForward:
            uiView.goForward()
        case .reload:
            uiView.reload()
        case .none:
            break
        }
        action = .none
    }

    func makeCoordinator() -> WebView.Coordinator {
        return Coordinator(parent: self)
    }

    static func dismantleUIView(_ uiView: WKWebView, coordinator: Coordinator) {
        coordinator.observations.forEach({ $0.invalidate() })
        coordinator.observations.removeAll()
    }
}

extension WebView {
    final class Coordinator: NSObject, WKNavigationDelegate {
        /// 親View
        let parent: WebView
        /// NSKeyValueObservation
        var observations: [NSKeyValueObservation] = []

        init(parent: WebView) {
            self.parent = parent

            let progressObservation = parent.webView.observe(\.estimatedProgress, options: .new, changeHandler: { _, value in
                parent.estimatedProgress = value.newValue ?? 0
            })
            let isLoadingObservation = parent.webView.observe(\.isLoading, options: .new, changeHandler: { _, value in
                parent.isLoading = value.newValue ?? false
            })
            observations = [
                progressObservation,
                isLoadingObservation
            ]
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.canGoBack = webView.canGoBack
            parent.canGoForward = webView.canGoForward
            parent.pageTitle = webView.title ?? ""
        }
    }
}
