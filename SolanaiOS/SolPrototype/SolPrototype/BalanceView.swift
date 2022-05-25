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
                        .background(Color.black)
                        .foregroundColor(Color.mint)
                        .cornerRadius(8.0)
                        .shadow(color: Color.gray, radius: 5, x: 5, y:5)
                    Spacer()
                }.padding()
                
                VStack  {
                    HStack {
                        Text("Wallet Address")
                            .font(.headline)
                            .padding()
                        Spacer()
                    }
                    Text("4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi")
                        .padding()
                    
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
                        NavigationLink("Send SOL", destination: SendSOLTokenView()).font(.headline).padding() .background(Color.black)
                            .foregroundColor(Color.mint)
                            .cornerRadius(8.0)
                            .shadow(color: Color.gray, radius: 5, x: 5, y:5)
                    }
                    
                }.padding()
                
                TransactionListView()
                Spacer()
            }
            .navigationTitle("Sol wallet")
        }
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView()
    }
}
