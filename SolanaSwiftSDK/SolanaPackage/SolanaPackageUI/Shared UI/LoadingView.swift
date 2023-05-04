//
//  LoadingView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/12/23.
//

import SwiftUI

struct LoadingView: View {
    @State private var currentProgress: CGFloat = 0.0
    @State private var isAnimating = false
    
    let title: String
    private let total: CGFloat = 1.0
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        VStack {
            ProgressView(title, value: currentProgress, total: total)
                .padding()
                .progressViewStyle(LinearProgressViewStyle(tint: Color.primary))
                .foregroundColor(Color.primary)
                .shadow(color: .primary, radius: 0.5)
        }
        .onAppear {
            isAnimating = true
            startAnimating()
        }
        .onDisappear {
            isAnimating = false
        }
    }
    
    private func startAnimating() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let remaining = total - currentProgress
            let increment = remaining / 20 // adjust rate of growth based on how close it is to total
            
            if currentProgress >= total {
                currentProgress = total
                timer.invalidate()
                isAnimating = false
            } else {
                currentProgress += increment
            }
        }
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoadingView(title: "Loading ...")
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Loading View")
        }
    }
}
