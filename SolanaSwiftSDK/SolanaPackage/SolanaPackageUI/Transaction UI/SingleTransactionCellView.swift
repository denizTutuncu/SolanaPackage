//
//  SingleTransactionCellVIew.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import SwiftUI

struct SingleTransactionCellView: View {
    @Binding var tx: TransactionUI
    let selection: () -> Void
    
    var body: some View {
        Button(action: selection, label: {
            VStack {
                HStack {
                    Text(tx.date)
                        .font(.system(size: 21, weight: .bold))
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                    Spacer()
                }
             
                HStack {
                    Rectangle()
                        .stroke(Color.secondary, lineWidth: 2.5)
                        .frame(width: 45.0, height: 29.0)
                        .overlay(
                            Text("from")
                                .font(.headline)
                                .foregroundColor(.primary)
                        )
                    Text(tx.from)
                        .font(.system(size: 19, weight: .black, design: .monospaced))
                        .minimumScaleFactor(0.3)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                    Spacer()
                }
                
                HStack {
                    Rectangle()
                        .stroke(Color.secondary, lineWidth: 2.5)
                        .frame(width: 45.0, height: 29.0)
                        .overlay(
                            Text("to")
                                .font(.headline)
                                .foregroundColor(.primary)
                        )
                    Text(tx.to)
                        .font(.system(size: 19, weight: .black, design: .monospaced))
                        .minimumScaleFactor(0.3)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                    Spacer()
                }
                
                HStack {
                    Rectangle()
                        .stroke(Color.secondary, lineWidth: 2.5)
                        .frame(width: 69.0, height: 29.0)
                        .overlay(
                            Text("amount")
                                .font(.headline)
                                .foregroundColor(.primary)
                        )
            
                    Text("\(tx.amount) \(tx.currencyName)")
                        .font(.headline)
                        .minimumScaleFactor(0.3)
                        .lineLimit(1)
                        .foregroundColor(Color.primary)
                        .shadow(color: .primary, radius: 0.5)
                    Spacer()
                }
                
                VStack {
                    
                    Rectangle()
                        .stroke(Color.secondary, lineWidth: 2.5)
                        .frame(width: .infinity, height: 29.0)
                        .overlay(
                            Text("TRANSACTION SIGNATURE")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        )
            
                    Text(tx.transactionSignature)
                        .font(.caption)
                        .minimumScaleFactor(0.3)
                        .foregroundColor(Color.primary)
                        .shadow(color: .primary, radius: 0.5)
                }
                
                
            }.padding()
        })
    }
    
    struct SingleTransactionCellView_Previews: PreviewProvider {
        static var previews: some View {
            SingleTransactionCellView(tx: .constant(TransactionUI(date: "Feb 23, 2023",
                                                                from: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                                                to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                                amount: "10000000000.00",
                                                                currencyName: "lamports",
                                                                transactionSignature: "5U3XaN8ab9mFWH47spgpE53jfFvCLeADBLdRDzfMt3yAsPDZBs3yWaSL58w6E83pquutbJA8CpsAGXAWmbNaCWaN")), selection: {})
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Single Seed Cell View")
        }
    }
}
