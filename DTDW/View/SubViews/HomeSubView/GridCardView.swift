//
//  GridCardView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI

struct GridCard: Identifiable {
    var id = UUID()
    var imageName: String
    var title: String
    var cashOnReturn: String
    var capRate: String
    var buttonAction: () -> Void
}

struct GridCardDemo: View {
    var cards: [GridCard] = [
        GridCard(
            imageName: "Picture",
            title: "Land Lady Apts on Martin St.",
            cashOnReturn: "Cash on Return 11.52%",
            capRate: "Cap Rate 8.33%",
            buttonAction: {
                print("View Deal")
            }
        ),
        GridCard(
            imageName: "Picture",
            title: "Sunny Apartments in Downtown",
            cashOnReturn: "Cash on Return 9.45%",
            capRate: "Cap Rate 7.12%",
            buttonAction: {
                print("View Deal")
            }
        ),
        GridCard(
            imageName: "Picture",
            title: "Oceanview Condos at Beachside",
            cashOnReturn: "Cash on Return 12.87%",
            capRate: "Cap Rate 8.99%",
            buttonAction: {
                print("View Deal")
            }
        )
    ]
    
    // Define grid layout with 2 columns
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(cards) { card in
                    GridCardView(card: card)
                        .padding(.bottom, 20) // Add spacing between cards
                }
            }
            .padding() // Add padding around the entire LazyVGrid
        }
    }
}


struct GridCardView: View {
    var card: GridCard
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Image(card.imageName)
                    .resizable()
                    .scaledToFill()
                
                VStack(alignment: .leading ,spacing: 8) {
                    Text(card.title)
                        .font(.system(size: 11))
                        .fontWeight(.bold)
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
                    
                    
                    Button {
                        card.buttonAction()
                    } label: {
                        Text("View Deal")
                            .font(.system(size: 10))
                            .minimumScaleFactor(0.5)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(#colorLiteral(red: 0.986738503, green: 0.9029306769, blue: 0.8132622838, alpha: 1)))
                    }
                    .frame(maxWidth: .infinity, maxHeight: 30)
                    .background(LinearGradient(colors: [Color(#colorLiteral(red: 0.6681778431, green: 0.0137046827, blue: 0.4076051712, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.8728173375, blue: 0.9318154454, alpha: 1))], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(50)
                    .padding(.horizontal, 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(LinearGradient(colors: [Color(#colorLiteral(red: 1, green: 0.9999999404, blue: 1, alpha: 0.5)), Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25))], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 0.94)
                            .padding(.horizontal, 20)
                    )
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.01)),radius: 4, x: 0, y: 1)
                    .padding(.bottom, 10)
                }
                .padding(.horizontal, 10)
            }
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.1), radius: 6, x: 1, y: 1)
        }
    }
}



struct GridCardView_Previews: PreviewProvider {
    static var previews: some View {
        GridCardView(card: GridCard(
            imageName: "Picture", // Replace with a valid image name in your assets
            title: "Land Lady Apts on Martin St.",
            cashOnReturn: "Cash on Return 11.52%",
            capRate: "Cap Rate 8.33%",
            buttonAction: {
                print("View Deal pressed")
            }
        ))
        .frame(width: 193, height: 208)
        .previewLayout(.sizeThatFits) // Adjusts the preview to fit the content size
    }
}
