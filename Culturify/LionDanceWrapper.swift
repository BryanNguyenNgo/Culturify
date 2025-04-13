//
//  ARViewControllerWrapper.swift
//  ARTest
//
//  Created by Bryan Nguyen on 20/3/25.
//
import SwiftUI
struct LionDanceWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LionDanceView {
        return LionDanceView() // Replace with your actual ViewController
    }
    
    func updateUIViewController(_ uiViewController: LionDanceView, context: Context) {
        // Any updates if needed
    }
}
