////
////  GetBalanceView.swift
////  SolanaPackageUI
////
////  Created by Deniz Tutuncu on 4/26/22.
////
//
//import SwiftUI
//import SolanaPackage
//
//public struct GetBalanceView: View {
//    private let viewModel: GetBalanceViewModel
//    
//    public init(viewModel: GetBalanceViewModel) {
//        self.viewModel = viewModel
//    }
//    
//    public var body: some View {
//        VStack {
//            Text("\(viewModel.model?.walletAddress ?? "Cannot find wallet address")")
//            Text("\(viewModel.model?.balance ?? "Cannot find balance")")
//        }.onAppear(perform: {
//            viewModel.loadBalance()
//        })
//    }
//}
//
//public extension GetBalanceView {
//    var balanceText: String {
//        return "\(viewModel.model?.balance ?? "Cannot find balance")"
//    }
//    
//    var walletAddressText: String {
//        return "\(viewModel.model?.walletAddress ?? "Cannot find wallet address")"
//    }
//}
//
//struct GetBalanceView_Previews: PreviewProvider {
//    static var previews: some View {
//        GetBalanceView(viewModel: GetBalanceViewModel(
//                        loader: RemoteGetBalanceLoader(
//                            client: URLSessionHTTPClient(
//                                session: URLSession(
//                                    configuration: .ephemeral)),
//                            urlMaker: GetBalanceURLRequestMaker(
//                                rpcEndpoint: SolanaClusterRPCEndpoints.devNet)), pubKey: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi"))
//        
//    }
//}
