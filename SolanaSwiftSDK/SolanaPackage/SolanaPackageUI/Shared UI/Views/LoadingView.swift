//
//  LoadingView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/12/23.
//

import SwiftUI

struct LoadingView: View, LoadingViewProtocol {
    @State internal var title: String
    @Binding internal var progress: CGFloat
    @Binding internal var total: CGFloat
    init(title: String, progress: Binding<CGFloat>, total: Binding<CGFloat>) {
        self.title = title
        self._progress = progress
        self._total = total
    }
    
    var body: some View {
        VStack {
            ProgressView(title, value: progress, total: total)
                .padding()
                .progressViewStyle(LinearProgressViewStyle(tint: Color.primary))
                .foregroundColor(Color.primary)
                .shadow(color: .primary, radius: 0.5)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoadingView(title: "Downloading ...", progress: .constant(0.5), total: .constant(1.0))
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Loading View")
        }
    }
}
