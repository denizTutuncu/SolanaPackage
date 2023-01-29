//
//  UIImage+TestHelpers.swift
//  SolanaPackageUITests
//
//  Created by Deniz Tutuncu on 1/12/23.
//

import SwiftUI

extension Image {
    static func snapshot(of view: AnyView) -> Image {
        let controller = UIHostingController(rootView: view)
        controller.view.frame = UIScreen.main.bounds
        controller.view.layoutIfNeeded()
        
        let image = UIGraphicsImageRenderer(bounds: controller.view.bounds).image { _ in
            controller.view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
        
        return Image(uiImage: image)
    }
}

