//
//  ResultDisplayableView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/3/23.
//

import SwiftUI

public struct ResultDisplayableView<ContentView: Displayable, ErrorView: ErrorViewProtocol>: View {
    public typealias ViewModel = ContentView.ViewModel
    @State private var viewModel: ViewModel?
    
    private let content: (ViewModel) -> ContentView
    private let errorView: () -> ErrorView
    
    public init(viewModel: ViewModel? = nil, content: @escaping (ViewModel) -> ContentView, errorView: @escaping () -> ErrorView) {
        self.viewModel = viewModel
        self.content = content
        self.errorView = errorView
    }
    
    public var body: some View {
        guard let viewModel = viewModel else { return AnyView(errorView()) }
        return AnyView(content(viewModel))
    }
}

struct ResultDisplayableView_Previews: PreviewProvider {
    static var previews: some View {
        
        struct SuccessView: Displayable {
            typealias ViewModel = String
            var viewModel: ViewModel?
            
            var body: some View {
                if let viewModel = viewModel {
                    return Text("Success: \(viewModel)")
                }
            }
        }
        
        struct ErrorView: ErrorViewProtocol {
            var message: String?
            
            var onHide: (() -> Void)?
            
            var body: some View {
                message != nil ? AnyView(Text("Error")) : AnyView(EmptyView())
            }
        }
        
        return ResultDisplayableView(viewModel: "View Model") { viewModel in
            SuccessView(viewModel: viewModel)
        } errorView: {
            ErrorView()
        }
    }
}
