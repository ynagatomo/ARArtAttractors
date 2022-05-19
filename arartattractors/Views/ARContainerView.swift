//
//  ARContainerView.swift
//  arartattractors
//
//  Created by Yasuhito Nagatomo on 2022/05/14.
//

import SwiftUI

struct ARContainerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARViewController
    let figure: Figure

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> ARViewController {
        return ARViewController(figure: figure)
    }

    func updateUIViewController(_ uiViewController: ARViewController,
                                context: Context) {
    }

    class Coordinator: NSObject {
        var parent: ARContainerView
        init(_ parent: ARContainerView) {
            self.parent = parent
        }
    }
}
