//
//  TransferView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/25/25.
//

import SwiftUI

public struct TransferView: View {
    public init(
        headerTitle: String,
        headerTitleTextColor: Color,
        headerSubtitle: String,
        headerSubtitleTextColor: Color,
        recipientTextFieldPlaceholder: String,
        amountTextFieldPlaceholder: String,
        cancelButtonTitle: String,
        cancelButtonAction: @escaping () -> Void,
        sendSOLButtonTitle: String,
        sendSOLButtonAction: @escaping () -> Void,
        viewModel: TransferViewModel
    ) {
        self.headerTitle = headerTitle
        self.headerTitleTextColor = headerTitleTextColor
        self.headerSubtitle = headerSubtitle
        self.headerSubtitleTextColor = headerSubtitleTextColor
        self.recipientTextFieldPlaceholder = recipientTextFieldPlaceholder
        self.amountTextFieldPlaceholder = amountTextFieldPlaceholder
        self.cancelButtonTitle = cancelButtonTitle
        self.cancelButtonAction = cancelButtonAction
        self.sendSOLButtonTitle = sendSOLButtonTitle
        self.sendSOLButtonAction = sendSOLButtonAction
        _viewModel = StateObject(wrappedValue: viewModel)
    }
  
    public let headerTitle: String
    public let headerTitleTextColor: Color
    public let headerSubtitle: String
    public let headerSubtitleTextColor: Color
    public let recipientTextFieldPlaceholder: String
    public let amountTextFieldPlaceholder: String
    public let cancelButtonTitle: String
    public let cancelButtonAction: () -> Void
    public let sendSOLButtonTitle: String
    public let sendSOLButtonAction: () -> Void
    
    @StateObject private var viewModel: TransferViewModel

    public var body: some View {
        VStack {
            HeaderView(
                title: headerTitle,
                titleTextColor: headerTitleTextColor,
                subtitle: headerSubtitle,
                subtitleTextColor: headerSubtitleTextColor
            )

            VStack(spacing: 20) {
                TextField(recipientTextFieldPlaceholder, text: Binding(
                    get: { viewModel.model.recipientPublicKey },
                    set: { viewModel.updateRecipientPublicKey($0) }
                ))
                .foregroundColor(.secondary)
                .fontWeight(.bold)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.horizontal)

                TextField(amountTextFieldPlaceholder, text: Binding(
                    get: { viewModel.model.amount },
                    set: { viewModel.updateAmount($0) }
                ))
                .foregroundColor(.secondary)
                .fontWeight(.bold)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            }

            if viewModel.isLoading {
                ProgressView()
                    .padding(.top)
            }

            HStack(spacing: 16) {
                Button(action: cancelButtonAction) {
                    Text(cancelButtonTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primary.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    viewModel.setLoading()
                    sendSol()
                    viewModel.setOffLoading()
                }) {
                    Text(sendSOLButtonTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }

    public func sendSol() {
        guard !viewModel.model.recipientPublicKey.isEmpty else {
            return
        }

        guard let amount = Double(viewModel.model.amount), amount > 0 else {
            return
        }

        sendSOLButtonAction()
    }
    
    public func cancel() {
        cancelButtonAction()
    }
}

struct SolTransferView_Previews: PreviewProvider {
    static var previews: some View {
        TransferView(headerTitle: "Send",
                        headerTitleTextColor: .primary,
                        headerSubtitle: "Transfer securely",
                        headerSubtitleTextColor: .blue,
                        recipientTextFieldPlaceholder: "Recipient Public Key",
                        amountTextFieldPlaceholder: "Amount",
                        cancelButtonTitle: "Cancel",
                        cancelButtonAction: {  print("Cancel button tapped") },
                        sendSOLButtonTitle: "Send",
                        sendSOLButtonAction: {  print("SendSOL button tapped") },
                        viewModel: TransferViewModel(model: TransferModel(recipientPublicKey: "", amount: ""))
      
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Transfer Test View")
    }
}
