//
//  BooksModel.swift
//  DTDW
//
//  Created by Sazza on 13/3/25.
//

import SwiftUI
import Foundation

struct BooksModel: Identifiable {
    var id = UUID()
    var imageName: String
    var title: String
    var url: URL
}
