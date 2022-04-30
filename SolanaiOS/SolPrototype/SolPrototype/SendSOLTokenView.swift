//
//  SendSOLTokenView.swift
//  SolPrototype
//
//  Created by Deniz Tutuncu on 4/28/22.
//

import SwiftUI

struct SendSOLTokenView: View {
   
    @State private var receiverTextField = ""
    @State private var amountTextField = ""
    
    var body: some View {
            
            VStack {
                
                HStack {
                    Text("to:").font(.headline)
                    Spacer()
                    Image("ScanIcon").resizable().frame(width: 29, height: 29, alignment: .center)
                }.padding()
                
                VStack {
                    TextField("Receiver address", text: $receiverTextField)
                }.padding()
                
                HStack {
                    Text("Amount").font(.headline)
                    Spacer()
                }.padding()
                
                VStack {
                    TextField("0 SOL", text: $amountTextField).keyboardType(.numbersAndPunctuation)
                }.padding()
                
                VStack {
                    Button("Send") {
                        
                    }.font(.headline).padding()
                }
                Spacer()
            }
            
        
    }
}

struct SendSOLTokenView_Previews: PreviewProvider {
    static var previews: some View {
        SendSOLTokenView()
    }
}
