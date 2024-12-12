//
//  ListCardView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI

struct ListCardView: View {
    var card: GridCard
    var onDelete: () -> Void
    
    var body: some View {
        ZStack {
            //List card button here
            Button {
               //button action here
            } label: {
                HStack {
                    Image(card.imageName)
                        .resizable()
                        .scaledToFill()
                        .clipShape(.circle)
                        .frame(width: 40, height: 40)
                    VStack(alignment: .leading ,spacing: 8) {
                        Text(card.title)
                            .font(.system(size: 11))
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                        
                        HStack(spacing: 10) {
                            Text(card.cashOnReturn)
                                .font(.system(size: 7))
                                .foregroundStyle(.black.opacity(0.5))
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                            
                            Text(card.capRate)
                                .font(.system(size: 7))
                                .foregroundStyle(.black.opacity(0.5))
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.deepPurpelColor)
                }
            }
            .padding(14)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(10)
            .padding(.horizontal, 20)
            .shadow(color: .black.opacity(0.1), radius: 6, x: 1, y: 1)
        }
        .swipeActions {
            Button(role: .destructive, action: onDelete) {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}
