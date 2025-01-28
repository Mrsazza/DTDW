//
//  DTDWSafariView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 28/1/25.
//

import SwiftUI
import SafariServices

struct DTDWSafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<DTDWSafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<DTDWSafariView>) {
    }
}
