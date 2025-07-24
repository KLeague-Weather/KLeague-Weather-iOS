//
//  UIViewController+Preview.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import UIKit
import SwiftUI

// MARK: - UIViewController Preview Extension
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            // 업데이트가 필요한 경우 여기에 구현
        }
    }

    func toPreview() -> some View {
        Preview(viewController: self)
    }
}

// MARK: - UIView Preview Extension
extension UIView {
    private struct Preview: UIViewRepresentable {
        let view: UIView

        func makeUIView(context: Context) -> UIView {
            return view
        }

        func updateUIView(_ uiView: UIView, context: Context) {
            // 업데이트가 필요한 경우 여기에 구현
        }
    }

    func toPreview() -> some View {
        Preview(view: self)
    }
} 
