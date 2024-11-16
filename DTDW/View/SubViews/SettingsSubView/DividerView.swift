//
//  DividerView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(maxWidth: .infinity, maxHeight: 2)
            .foregroundStyle(Color.dividerColor)
    }
}
