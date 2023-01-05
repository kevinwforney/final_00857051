//
//  ShareSheet.swift
//  final_00857051
//
//  Created by User03 on 2023/1/4.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems:
            [
                "League of Legends",
                URL(string: "https://developer.riotgames.com/")!
            ],
                                 applicationActivities: nil
        )
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        print("Update UI View Controller")
    }
    typealias UIViewControllerType = UIActivityViewController
}
