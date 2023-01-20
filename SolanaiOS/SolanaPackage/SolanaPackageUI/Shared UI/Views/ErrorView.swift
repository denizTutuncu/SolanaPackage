//
//  BalanceLoadingView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI

public struct ErrorView: View {
    @Binding var message: String?
    var onHide: (() -> Void)?
    
    public var body: some View {
        VStack(alignment: .center) {
            if message != nil {
                Text(message!)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.errorBackgroundColor)
                Button(action: hideMessage) {
                    Text("Try again")
                        .foregroundColor(.white)
                }
                .padding(8)
                .background(Color.errorBackgroundColor)
            }
        }.padding()
    }
    
    public func setMessageAnimated(_ message: String?) {
        self.message = message
    }
    
    private func hideMessage() {
        message = nil
        onHide?()
    }
}

extension Color {
    static var errorBackgroundColor: Color {
        Color(red: 0.99951404330000004, green: 0.41759261489999999, blue: 0.4154433012)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ErrorView(message: .constant("An error occurred."), onHide: { print("Error dismissed.") })
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Error View")
        }
    }
}
