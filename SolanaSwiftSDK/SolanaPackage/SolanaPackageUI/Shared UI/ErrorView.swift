//
//  ErrorView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI

struct ErrorView: View {
    @State var message: String?
    let buttonTitle: String?
    let onHide: (() -> Void)?
    
    init(message: String?, buttonTitle: String?, onHide: (() -> Void)?) {
        self.message = message
        self.buttonTitle = buttonTitle
        self.onHide = onHide
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if message != nil && buttonTitle != nil {
                Text(message!)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.errorBackgroundColor)
                Button(action: hideMessage) {
                    Text(buttonTitle!)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(8)
                .background(Color.errorBackgroundColor)
            }
        }.padding()
    }
    
    private func hideMessage() {
        message = nil
        onHide?()
    }
}

private extension Color {
    static var errorBackgroundColor: Color {
        Color(red: 0.99951404330000004, green: 0.41759261489999999, blue: 0.4154433012)
    }
}


struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ErrorTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Error Test View")
        }
    }
    
    struct ErrorTestView: View {
        @State var tapped = false
        
        var body: some View {
            VStack {
                ErrorView(message: "Couldn't connect to network.",
                          buttonTitle: "Try again",
                          onHide: { tapped.toggle() })
                Text("Create wallet tapped: \(tapped.description)")
            }
        }
    }
}
