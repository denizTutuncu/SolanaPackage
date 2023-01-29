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
            HStack {
                Image("Solana")
                    .resizable()
                    .frame(width: screenSize.height / 12, height: screenSize.height / 12, alignment: .center)
                
                Button {
                    self.isWalletCreated.toggle()
                } label: {
                    Text("Create Solana wallet")
                        .font(.title2)
                        .bold()
                }
                .fixedSize(horizontal: true, vertical: false)
                .padding()
                .background(Color.black)
                .foregroundColor(Color.mint)
                .cornerRadius(8.0)
                .shadow(color: Color.gray, radius: 5, x: 5, y:5)
            }
            
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
