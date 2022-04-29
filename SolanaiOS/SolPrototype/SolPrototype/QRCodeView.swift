//
//  QRCodeView.swift
//  SolPrototype
//
//  Created by Deniz Tutuncu on 4/28/22.
//

import SwiftUI

struct QRCodeView: View {
    var body: some View {
        VStack {
            Text("4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi").fixedSize(horizontal: true, vertical: false).padding()
            HStack {
                Image("SOLAddress")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
        }
       
    }
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView()
    }
}
