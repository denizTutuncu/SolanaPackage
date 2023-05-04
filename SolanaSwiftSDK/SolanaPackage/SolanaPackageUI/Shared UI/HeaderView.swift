//
//  HeaderView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import SwiftUI

struct HeaderView: View {
    let title: String?
    let subtitle: String?
    
    var body: some View {
        HStack {
            if (title != nil), (subtitle != nil) {
                VStack(alignment: .leading, spacing: 16.0) {
                    Text(subtitle!)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                        .minimumScaleFactor(0.8)
                    
                    Text(title!)
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .minimumScaleFactor(0.8)
                        .foregroundColor(.primary)
                }
                .padding(.top)
                
                Spacer()
            }
            
          
        }.padding()
    }
}

struct QuestionHeader_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "A title", subtitle: "A subtitle")
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Header View")
        
    }
}
