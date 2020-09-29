//
//  RichWebView.swift
//  RichWebViewSample
//
//  Created by 青木孝乃輔 on 2020/09/27.
//

import SwiftUI

struct RichWebView: View {

    /// URL
    let url = URL(string: "https://qiita.com")!
    /// アクション
    @State private var action: WebView.Action = .none
    /// 戻れるか
    @State private var canGoBack: Bool = false
    /// 進めるか
    @State private var canGoForward: Bool = false
    /// 読み込みの進捗状況
    @State private var estimatedProgress: Double = 0.0
    /// ローディング中かどうか
    @State private var isLoading: Bool = false
    /// ページタイトル
    @State private var pageTitle: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if isLoading {
                    ProgressBarView(estimatedProgress: estimatedProgress)
                }
                WebView(url: url,
                        action: $action,
                        canGoBack: $canGoBack,
                        canGoForward: $canGoForward,
                        estimatedProgress: $estimatedProgress,
                        isLoading: $isLoading,
                        pageTitle: $pageTitle)
                    .navigationBarTitle(Text(pageTitle), displayMode: .inline)
                WebToolBarView(action: $action,
                               canGoBack: canGoBack,
                               canGoForward: canGoForward)
            }
        }
    }
}

struct RichWebView_Previews: PreviewProvider {
    static var previews: some View {
        RichWebView()
    }
}
