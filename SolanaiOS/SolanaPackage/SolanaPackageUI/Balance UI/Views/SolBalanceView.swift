//
//  SolBalanceView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SolanaPackage
import SwiftUI

struct SolBalanceView: View, ResourceView {
    @State private var balance: BalanceViewModel
    
    init(balance: BalanceViewModel) {
        self.balance = balance
    }
    
    func display(_ viewModel: BalanceViewModel) {
        self.balance = viewModel
    }
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        VStack {
            Text("Solana")
                .bold()
                .padding()
            
            Text("\(self.balance.balance.value / 1000000000) Sol")
                .bold()
                .italic()
                .padding()
        }.onAppear(perform: {
            self.display(self.balance)
        })
        .frame(width: screenSize.width / 1.1, alignment: .center)
        .background(.purple)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}

struct SolBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        SolBalanceView(balance: BalanceViewModel(balance: Balance(value: 25000000000)))
    }
}
