//
//  TransactionListView.swift
//  SolPrototype
//
//  Created by Deniz Tutuncu on 4/28/22.
//

import SwiftUI

struct TransactionListView: View {
    @State var transactionArray: [Transaction] = [
        Transaction(id: UUID(), from: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi", to: "14ivtgssEBoBjuZJtSAPKYgpUK7DmnSwuPMqJoVTSgKJ", amount: "7.35 SOL", date: "Thu, April 28, 2022"),
        Transaction(id: UUID(), from: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi", to: "56sevgssLPoCjzZKtSAKBGgpTR7AmzLppPwFoVFGxOP", amount: "12.55 SOL", date: "Fri, April 29, 2022")
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("History").font(.title).padding()
                Spacer()
            }
            
            ScrollView {
                ForEach(self.transactionArray, id: \.id) { transaction in
                    VStack {
                        
                        VStack{
                            HStack {
                                Text("Date:").font(.headline)
                                Spacer()
                            }
                            HStack {
                                Text("\(transaction.date)").lineLimit(nil)
                                Spacer()
                            }
                        }
                        
                        VStack {
                            HStack {
                                Text("Transaction id:").font(.headline)
                                Spacer()
                            }
                            HStack {
                                Text("\(transaction.id)").lineLimit(nil)
                                Spacer()
                            }
                        }
                        VStack {
                            HStack {
                                Text("from:").font(.headline)
                                Spacer()
                            }
                            HStack {
                                Text("\(transaction.from)").lineLimit(nil)
                                Spacer()
                            }
                        }
                        
                        VStack {
                            HStack {
                                Text("to:").font(.headline)
                                Spacer()
                            }
                            HStack {
                                Text("\(transaction.to)").lineLimit(nil)
                                Spacer()
                            }
                        }
                        
                        VStack{
                            HStack {
                                Text("amount:").font(.headline)
                                Spacer()
                            }
                            HStack {
                                Text("\(transaction.amount)").lineLimit(nil)
                                Spacer()
                            }
                            
                        }
                        
                        
                    }.padding()
                    
                }
                
            }
            
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
    }
}
