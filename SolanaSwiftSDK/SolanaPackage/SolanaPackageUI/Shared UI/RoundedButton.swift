//
//  RoundedButton.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/24/23.
//

import SwiftUI

struct RoundedButton: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void
    let backgroundColor: Color

    @State private var isPressed = false
    
    init(title: String, isEnabled: Bool = true, action: @escaping () -> Void, backgroundColor: Color) {
        self.title = title
        self.isEnabled = isEnabled
        self.action = action
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        Button(action: {
            isPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
            }
            action()
        }, label: {
            HStack {
                Spacer()
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .shadow(color: .white.opacity(0.5), radius: 0.5)
                    .padding()
                    .foregroundColor(.white)
                Spacer()
            }
            .background(backgroundColor)
            .cornerRadius(25)
            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5) // Floating effect
            .scaleEffect(isPressed ? 0.95 : 1.0) // Press animation
            .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0), value: isPressed)
        })
        .padding()
        .buttonStyle(PlainButtonStyle())
        .disabled(!isEnabled)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RoundedButton(title: "Enabled", isEnabled: true, action: {}, backgroundColor: Color.blue)
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Enabled Rounded Button")
            
            RoundedButton(title: "Disabled", isEnabled: false, action: {}, backgroundColor: Color.gray)
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Disabled Rounded Button")
        }
    }
}

