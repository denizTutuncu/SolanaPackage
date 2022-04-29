//
//  BalanceView.swift
//  SolPrototype
//
//  Created by Deniz Tutuncu on 4/28/22.
//

import SwiftUI

struct BalanceView: View {
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    NavigationLink("Receive SOL", destination: QRCodeView()).font(.headline).padding()
                    Spacer()
                }
                
                VStack  {
                    HStack {
                        Text("Wallet Address").font(.headline).padding()
                        Spacer()
                    }
                    Text("4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi").fixedSize(horizontal: true, vertical: false).padding()

                }.padding()
                
                HStack {
                    
                    VStack {
                        Text("Balance").padding().font(.headline)
                        
                        HStack {
                            Text("25").font(.title)
                            Image("SOLCoin")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 48, height: 48, alignment: .center)                    }
                    }
                    .padding()

                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink("Send SOL", destination: SendSOLTokenView()).font(.headline).padding()
                    }
                    
                }.padding()
                
                TransactionListView()
                Spacer()
            }
        }
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView()
    }
}
