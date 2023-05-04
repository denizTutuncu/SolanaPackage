//
//  ToogleView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 3/1/23.
//

import SwiftUI

struct ToogleView: View {
    let isOFFTitle: String
    let isONTitle: String
    @Binding var isOn: Bool
    
    init(isOFFTitle: String, isONTitle: String, isOn: Binding<Bool>) {
        self.isOFFTitle = isOFFTitle
        self.isONTitle = isONTitle
        self._isOn = isOn
    }
    
    var body: some View {
        VStack {
            Toggle(!isOn ? isOFFTitle : isONTitle, isOn: $isOn)
                .font(.system(size: 21, weight: .bold))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .foregroundColor(isOn ? .blue : .red)
                .contrast(100.0)
        }.padding()
    }
}

struct ToogleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ToogleTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Toogle Test View")
        }
    }
}

struct ToogleTestView: View {
    @State var isSafe: Bool = false
    
    var body: some View {
        VStack {
            
            ToogleView(isOFFTitle: "Seed phrase is not safe yet.",
                       isONTitle: "Seed phrase is safe now.",
                       isOn: $isSafe)
            
            Text("isSafe: " + "\(isSafe.description)").padding()
        }
    }
}

