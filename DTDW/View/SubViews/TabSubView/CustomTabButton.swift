//
//  CustomTabButton.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct CustomTabButton: View {
    var imageNameWhite: String
    var imageNameBlack: String
    var tabText: String
    var isActive: Bool
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 5) {
                Image(isActive ? imageNameBlack : imageNameWhite)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 24)
                    .foregroundColor(isActive ? .black : .gray)
                Text(tabText)
                    .font(.system(size: 12))
                    .foregroundColor(isActive ? .black : .gray)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}
