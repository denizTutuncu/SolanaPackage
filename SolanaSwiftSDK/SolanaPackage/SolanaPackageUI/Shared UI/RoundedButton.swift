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
    
    init(title: String, isEnabled: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.isEnabled = isEnabled
        self.action = action
    }
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                Spacer()
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .shadow(color: .white, radius: 0.2)
                    .padding()
                    .foregroundColor(Color.white)
                Spacer()
            }
            .background(Color.blue)
            .cornerRadius(25)
        })
        .padding()
        .buttonStyle(PlainButtonStyle())
        .disabled(!isEnabled)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RoundedButton(title: "Enabled", isEnabled: true, action: {})
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Enabled Rounded Button")
            
            RoundedButton(title: "", isEnabled: false, action: {})
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Disabled Rounded Button")
        }
    }
}
