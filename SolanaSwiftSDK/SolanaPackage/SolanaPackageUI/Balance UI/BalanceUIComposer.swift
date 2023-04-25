//
//  BalancUIComposer.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/16/23.
//

import SwiftUI

struct BalanceUIComposer: View {
    let title: String
    let currencyName: String
    let errorMessage: String
    let downloadingTitle: String
    let tryAgain: () -> Void
    
    @State var onLoadingState: Bool = true
    @State var viewModel: String?
    
    var body: some View {
        if onLoadingState {
            LoadingView(title: downloadingTitle)
        } else {
            HStack(alignment: .center, spacing: 8.0) {
                Text(title)
                    .font(.headline)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .foregroundColor(Color.primary)
                    .shadow(color: .primary, radius: 0.5)
                
                
                BalanceErrorComposerView(errorMessage: errorMessage,
                                         tryAgain: tryAgain,
                                         balance: viewModel)
                Text(currencyName)
                    .font(.headline)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .foregroundColor(Color.primary)
                    .shadow(color: .primary, radius: 0.5)
                
            }.padding()
        }
    }
}



struct BalancUIComposer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BalanceUIComposerTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Balance UI Composer Test View")
        }
    }
}

struct BalanceUIComposerTestView: View {
    @State var isON: Bool = false
    
    var body: some View {
        VStack {
            BalanceUIComposer(title: "",
                              currencyName: "",
                              errorMessage: "",
                              downloadingTitle: "Downloading balance",
                              tryAgain: {} ,
                              onLoadingState: true,
                              viewModel: nil)
            
            BalanceUIComposer(title: "Balance:",
                              currencyName: "lamports",
                              errorMessage: "Cannot connect to network",
                              downloadingTitle: "Downloading balance",
                              tryAgain: {} ,
                              onLoadingState: false,
                              viewModel: "10000000000.0000")
            
        }
    }
}
