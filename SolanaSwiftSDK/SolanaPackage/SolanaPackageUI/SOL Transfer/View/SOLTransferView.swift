//
//  SOLTransferView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/25/25.
//

import SwiftUI

public struct SolTransferView: View {
    public init(
        headerTitle: String,
        headerTitleTextColor: Color,
        headerSubtitle: String,
        headerSubtitleTextColor: Color,
        cancelButtonAction: @escaping () -> Void,
        sendSOLButtonAction: @escaping () -> Void,
        viewModel: SendSOLViewModel
    ) {
        self.headerTitle = headerTitle
        self.headerTitleTextColor = headerTitleTextColor
        self.headerSubtitle = headerSubtitle
        self.headerSubtitleTextColor = headerSubtitleTextColor
        self.cancelButtonAction = cancelButtonAction
        self.sendSOLButtonAction = sendSOLButtonAction
        _viewModel = StateObject(wrappedValue: viewModel)
    }
  
    public let headerTitle: String
    public let headerTitleTextColor: Color
    public let headerSubtitle: String
    public let headerSubtitleTextColor: Color
    public let cancelButtonAction: () -> Void
    public let sendSOLButtonAction: () -> Void
    
    @StateObject private var viewModel: SendSOLViewModel

    public var body: some View {
        VStack {
            HeaderView(
                title: headerTitle,
                titleTextColor: headerTitleTextColor,
                subtitle: headerSubtitle,
                subtitleTextColor: headerSubtitleTextColor
            )

            VStack(spacing: 20) {
                TextField("Recipient Public Key", text: Binding(
                    get: { viewModel.model.recipientPublicKey },
                    set: { viewModel.updateRecipientPublicKey($0) }
                ))
                .foregroundColor(.secondary)
                .fontWeight(.bold)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.horizontal)

                TextField("Amount (SOL)", text: Binding(
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
                    Text("Cancel")
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
                    Text("Send")
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
            print("Recipient public key cannot be empty.")
            return
        }

        guard let amount = Double(viewModel.model.amount), amount > 0 else {
            print("Please enter a valid amount greater than 0.")
            return
        }

        print("Sending \(amount) SOL to \(viewModel.model.recipientPublicKey)")
        sendSOLButtonAction()
    }
    
    public func cancel() {
        cancelButtonAction()
    }
}

struct SolTransferView_Previews: PreviewProvider {
    static var previews: some View {
        SolTransferView(headerTitle: "Send SOL",
                        headerTitleTextColor: .primary,
                        headerSubtitle: "Transfer securely",
                        headerSubtitleTextColor: .blue,
                        cancelButtonAction: {  print("Cancel button tapped") },
                        sendSOLButtonAction: {  print("SendSOL button tapped") },
                        viewModel: SendSOLViewModel(model: SendSOLModel(recipientPublicKey: "", amount: ""))
      
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Sol Transfer Test View")
    }
}
