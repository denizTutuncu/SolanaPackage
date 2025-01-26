//
//  ReceiveSOLView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/25/25.
//

import SwiftUI

public struct ReceiveSOLView: View {
    public init(
        headerTitle: String,
        headerTitleTextColor: Color,
        headerSubtitle: String,
        headerSubtitleTextColor: Color,
        backButtonTitle: String,
        backButtonAction: @escaping () -> Void,
        viewModel: ReceiveSOLViewModel
    ) {
        self.headerTitle = headerTitle
        self.headerTitleTextColor = headerTitleTextColor
        self.headerSubtitle = headerSubtitle
        self.headerSubtitleTextColor = headerSubtitleTextColor
        self.backButtonTitle = backButtonTitle
        self.backButtonAction = backButtonAction
        self.viewModel = viewModel
    }
    
    public let headerTitle: String
    public let headerTitleTextColor: Color
    public let headerSubtitle: String
    public let headerSubtitleTextColor: Color
    public let backButtonTitle: String
    public let backButtonAction: () -> Void
    
    @ObservedObject private var viewModel: ReceiveSOLViewModel
    
    public var body: some View {
        VStack {
            HeaderView(
                title: headerTitle,
                titleTextColor: headerTitleTextColor,
                subtitle: headerSubtitle,
                subtitleTextColor: headerSubtitleTextColor
            )
            
            VStack {
                
                Text("Receiver")
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                Text(viewModel.model.address)
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                if !viewModel.model.qrCodeData.isEmpty,
                   let uiImage = UIImage(data: viewModel.model.qrCodeData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .padding()
                } else {
                    Text("Unable to generate QR Code")
                        .foregroundColor(.gray)
                }
                
            }

            Button(action: backButtonAction) {
                Text(backButtonTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

struct ReceiveSOLView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ReceiveSOLModel(address: "CwdjgD54hgTQChspxHhirWLQWqy3EsxtndrcpLBqpump",
                                    qrCodeData: generateSampleQRCode("CwdjgD54hgTQChspxHhirWLQWqy3EsxtndrcpLBqpump") ?? Data())
        let viewModel = ReceiveSOLViewModel(model: model)

        return ReceiveSOLView(headerTitle: "Receive SOL",
                              headerTitleTextColor: .primary,
                              headerSubtitle: "Receive securely",
                              headerSubtitleTextColor: .blue,
                              backButtonTitle: "Back",
                              backButtonAction: { print("Back button tapped")},
                              viewModel: viewModel)
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Receive SOL Test View")
    }

    static func generateSampleQRCode(_ string: String) -> Data? {
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10))
            let context = CIContext()
            if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                let uiImage = UIImage(cgImage: cgImage)
                return uiImage.pngData()
            }
        }
        return nil
    }
}
