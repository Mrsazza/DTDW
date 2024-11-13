//
//  RectangleDashLine.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct RectangleDashLine: View {
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: 1)
            .foregroundColor(.black.opacity(0.5))
            .mask(
                HStack(spacing: 4) {
                    ForEach(0..<50) { _ in
                        Rectangle()
                            .frame(width: 5)
                    }
                }
            )
           
    }
}
