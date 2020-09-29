//
//  ProgressBarView.swift
//  RichWebViewSample
//
//  Created by 青木孝乃輔 on 2020/09/27.
//

import SwiftUI

struct ProgressBarView: View {

    /// 読み込みの進捗状況
    var estimatedProgress: Double

    var body: some View {
        VStack {
            GeometryReader { geometry in
                Rectangle()
                    .foregroundColor(Color.gray)
                    .opacity(0.3)
                    .frame(width: geometry.size.width)
                Rectangle()
                    .foregroundColor(Color.blue)
                    .frame(width: geometry.size.width * CGFloat(estimatedProgress))
            }
        }.frame(height: 3.0)
    }
}
