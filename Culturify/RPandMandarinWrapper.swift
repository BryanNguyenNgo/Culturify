//
//  ARViewControllerWrapper.swift
//  ARTest
//
//  Created by Bryan Nguyen on 20/3/25.
//
import SwiftUI
struct RPandMandarinWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RPMViewController {
        return RPMViewController() // Replace with your actual ViewController
    }
    
    func updateUIViewController(_ uiViewController: RPMViewController, context: Context) {
        // Any updates if needed
    }
}
