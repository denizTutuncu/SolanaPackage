//
//  GenericView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/6/24.
//

import SwiftUI

struct GenericView<T>: View, AnyViewProtocol where T: View {
    var data: T
    @State private var internalData: T

    init(data: T) {
        self.data = data
        _internalData = State(initialValue: data)
    }

    var body: some View {
        internalData
    }

    func updateData(_ newData: T) {
        internalData = newData
    }
}

#Preview {
    GenericView(data: Text("Hello, Generic View!"))
        .padding()
}
