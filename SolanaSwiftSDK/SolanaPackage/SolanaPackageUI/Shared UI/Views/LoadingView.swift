//
//  LoadingView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/12/23.
//

import SwiftUI

public struct LoadingView: View {
    @State private var progress: CGFloat
    
    init(progress: CGFloat) {
        self.progress = progress
    }
    
    public var body: some View {
        VStack {
            ProgressView("Loading Balance", value: progress, total: 1)
                .padding()
                .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
                .foregroundColor(Color.blue)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoadingView(progress: 0.5)
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Loading View")
        }
    }
}
