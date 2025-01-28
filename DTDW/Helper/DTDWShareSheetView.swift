//
//  DTDWShareSheet.swift
//  DTDW
//
//  Created by Sopnil Sohan on 28/1/25.
//

import UIKit
import SwiftUI
import MessageUI

struct DTDWShareSheetView: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
