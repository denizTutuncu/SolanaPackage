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
                .foregroundColor(isOn ? .green : .red)
            
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
    @State var isON: Bool = false
    
    var body: some View {
        VStack {
            
            ToogleView(isOFFTitle: "My seed phrase is not safe yet.",
                       isONTitle: "My seed phrase is safe now.",
                       isOn: $isON)
            
            Text("Last selection: " + "\(isON.description)").padding()
        }
    }
}

