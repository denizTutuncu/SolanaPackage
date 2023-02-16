//
//  DisplayableView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/3/23.
//

import SwiftUI

public struct DisplayableView<ContentView: DisplayableProtocol>: View {
    public typealias ViewModel = ContentView.ViewModel
    
    @State private var viewModel: ViewModel?
    private let contentView: (ViewModel?) -> ContentView
  
    public init(content: @escaping (ViewModel?) -> ContentView, viewModel: ViewModel? = nil) {
        self.contentView = content
        self.viewModel = viewModel
    }
    
    public var body: some View {
        AnyView(contentView(viewModel))
    }
}

struct ResultDisplayableView_Previews: PreviewProvider {
    static var previews: some View {
        
        struct SuccessView: DisplayableProtocol {
            typealias ViewModel = String
            var viewModel: ViewModel?
            
            var body: some View {
                if let viewModel = viewModel {
                    AnyView(Text("Success: \(viewModel)"))
                } else {
                    AnyView(EmptyView())
                }
                
            }
        }
        
        return  Group {
            DisplayableView() { viewModel in
                SuccessView(viewModel: "String View Model")
            }
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Displayable View")
        }
    }
}
