//
//  WebToolBarView.swift
//  RichWebViewSample
//
//  Created by 青木孝乃輔 on 2020/09/27.
//

import SwiftUI

struct WebToolBarView: View {

    /// アクション
    @Binding var action: WebView.Action
    /// 戻れるか
    var canGoBack: Bool
    /// 進めるか
    var canGoForward: Bool

    var body: some View {
        VStack() {
            Divider()
            HStack(spacing: 16) {
                Button("Back") {
                    action = .goBack
                }.disabled(!canGoBack)
                Button("Forward") {
                    action = .goForward
                }.disabled(!canGoForward)
                Spacer()
                Button("Reload") {
                    action = .reload
                }
            }
            .padding(.top, 8)
            .padding(.horizontal, 16)
            Spacer()
        }.frame(height: 60)
    }
}
