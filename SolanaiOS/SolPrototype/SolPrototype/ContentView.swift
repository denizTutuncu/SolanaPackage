//
//  ContentView.swift
//  SolPrototype
//
//  Created by Deniz Tutuncu on 3/28/22.
//

import SwiftUI


struct ContentView: View {
    @State private var isWalletCreated = false
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
            VStack {
                Spacer()
                Button("Create a new wallet") {
                    self.isWalletCreated.toggle()
                }.fixedSize(horizontal: true, vertical: false).padding()
                .background(Color.purple)
                .foregroundColor(Color.white)
                .font(.headline)
                .cornerRadius(8.0)
                .shadow(color: Color.gray, radius: 5, x: 0, y:-2)
                .frame(width: screenSize.width / 1.5, height: screenSize.height / 10, alignment: .center)
            }.padding()
        .fullScreenCover(isPresented: $isWalletCreated, content: {
            BalanceView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
