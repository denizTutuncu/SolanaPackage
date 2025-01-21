//
//  HeaderView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import SwiftUI

struct HeaderView: View {
    let title: String?
    let titleTextColor: Color?
    let subtitle: String?
    let subtitleTextColor: Color?
    
    var body: some View {
        HStack {
            if (title != nil), (subtitle != nil) {
                VStack(alignment: .leading, spacing: 16.0) {
                    Text(subtitle!)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(subtitleTextColor)
                        .minimumScaleFactor(0.8)
                    
                    Text(title!)
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .minimumScaleFactor(0.8)
                        .foregroundColor(titleTextColor)
                }
                .padding(.top)
                
                Spacer()
            }
            
          
        }.padding()
    }
}

struct QuestionHeader_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "A title",
                   titleTextColor: .blue,
                   subtitle: "A subtitle",
                   subtitleTextColor: .blue)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Header View")
        
    }
}
