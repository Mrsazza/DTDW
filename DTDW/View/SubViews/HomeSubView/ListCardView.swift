//
//  ListCardView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI

struct ListCardView: View {
    var card: HomeCardModel

    var body: some View {
        HStack {
            if let imageData = card.imageName, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .clipShape(.circle)
                    .frame(width: 40, height: 40)
            } else {
                Image("Picture")
                    .resizable()
                    .scaledToFill()
                    .clipShape(.circle)
                    .frame(width: 40, height: 40)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(card.title)
                    .font(.system(size: 11))
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)

                HStack(spacing: 8) {
                    HStack(spacing: 2) {
                        Text(card.cashOnReturn)
                            .font(.system(size: 7))
                            .foregroundStyle(.black.opacity(0.5))
                            .fontWeight(.bold)
                            .minimumScaleFactor(1)
                            .lineLimit(1)
                        Text("\(card.cashOnReturnData, specifier: "%.2f")%")
                            .font(.system(size: 7))
                            .foregroundStyle(card.cashOnReturnData < 0 ? Color.red : Color.green)
                            .fontWeight(.bold)
                            .minimumScaleFactor(1)
                            .lineLimit(1)
                    }
                    HStack(spacing: 2) {
                        Text(card.capRate)
                            .font(.system(size: 7))
                            .foregroundStyle(.black.opacity(0.5))
                            .fontWeight(.bold)
                            .minimumScaleFactor(1)
                            .lineLimit(1)
                        Text("\(card.capRateData, specifier: "%.2f")%")
                            .font(.system(size: 7))
                            .foregroundStyle(card.capRateData < 0 ? Color.red : Color.green)
                            .fontWeight(.bold)
                            .minimumScaleFactor(1)
                            .lineLimit(1)
                    }
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 12))
                .fontWeight(.bold)
                .foregroundStyle(Color.deepPurpelColor)
        }
        .padding(14)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
        .padding(.horizontal, 20)
        .shadow(color: .black.opacity(0.1), radius: 6, x: 1, y: 1)
        .contentShape(Rectangle())
        .highPriorityGesture(
            TapGesture()
                .onEnded {
                    card.buttonAction()
                }
        )
    }
}

struct SwipeableCardView: View {
    var card: HomeCardModel
    var deleteAction: () -> Void

    @State private var offset: CGFloat = 0
    @GestureState private var isDragging = false

    var body: some View {
        ZStack(alignment: .trailing) {
            // Background Delete Button
            if offset < 0 {
                Button(action: deleteAction) {
                    HStack {
                        Image(systemName: "trash.fill")
                            .foregroundColor(.white)
                        Text("Delete")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.red)
                    .cornerRadius(10)
                }
                .padding(.trailing, 20)
                .transition(.move(edge: .trailing))
            }

            // Foreground Card View
            ListCardView(card: card)
                .offset(x: offset)
                .simultaneousGesture(
                    DragGesture()
                        .onChanged { gesture in
                            if abs(gesture.translation.width) > 10 && abs(gesture.translation.width) > abs(gesture.translation.height) {
                                offset = gesture.translation.width
                            }
                        }
                        .onEnded { gesture in
                            withAnimation(.smooth) {
                                if offset < -100 {
                                    offset = -120
                                } else {
                                    offset = 0
                                }
                            }
                        }
                )
        }
    }
}
