//
//  LoadingView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/12/23.
//

import SwiftUI

public struct LoadingView: View {
    @Binding public var progress: CGFloat
    
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
            LoadingView(progress: .constant(0.5))
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Loading View")
        }
    }
}
