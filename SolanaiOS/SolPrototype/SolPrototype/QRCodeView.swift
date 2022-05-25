//
//  QRCodeView.swift
//  SolPrototype
//
//  Created by Deniz Tutuncu on 4/28/22.
//

import SwiftUI

struct QRCodeView: View {
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        VStack {
            VStack(alignment: .leading) {
                Text("Sol Account Address")
                    .font(.title2)
                    .bold()
                    .padding()
                Text("4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi")
                    .font(.title2)
                    .bold()
                    .padding()
            }
            HStack {
                Image("SOLAddress")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenSize.width / 2, alignment: .center)
            } .padding()
            Spacer()
        }.padding()
    }
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView()
    }
}
