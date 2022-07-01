//
//  SolBalanceView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SolanaPackage
import SwiftUI

struct BalanceView: View {
    
    @State private var balance: BalanceViewModel
    
    init(balance: BalanceViewModel) {
        self.balance = balance
    }
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        VStack {
            Text("Solana")
                .font(Font.largeTitle)
                .bold()
                .padding()
            
            Text("\(self.balance.balance.lamports / 1000000000) SOL")
                .font(Font.title)
                .italic()
                .padding()
        }
        .frame(width: screenSize.width / 1.5, alignment: .center)
        .background(.purple)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}

struct SolBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView(balance: BalanceViewModel(balance: Balance(lamports: 25000000000)))
    }
}
