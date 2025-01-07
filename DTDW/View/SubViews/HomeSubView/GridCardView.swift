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
    var cashOnReturnData: Double
    var capRate: String
    var capRateData: Double
    var buttonAction: () -> Void
}

struct ListCardView: View {
    var card: GridCard
    
    var body: some View {
        ZStack {
            Button {
                card.buttonAction()
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
                                    .foregroundStyle(Color(#colorLiteral(red: 0.5127275586, green: 0.7354346514, blue: 0.1412258446, alpha: 1)))
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
                                    .foregroundStyle(Color(#colorLiteral(red: 0.5127275586, green: 0.7354346514, blue: 0.1412258446, alpha: 1)))
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
            }
            .padding(14)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(10)
            .padding(.horizontal, 20)
            .shadow(color: .black.opacity(0.1), radius: 6, x: 1, y: 1)
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
                        .foregroundStyle(Color.black)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                    
                    HStack(spacing: 10) {
                        
                        HStack(spacing: 3) {
                            Text(card.cashOnReturn)
                                .font(.system(size: 7))
                                .foregroundStyle(.black.opacity(0.5))
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                            Text("\(card.cashOnReturnData, specifier: "%.2f")%")
                                .font(.system(size: 7))
                                .foregroundStyle(Color(#colorLiteral(red: 0.5127275586, green: 0.7354346514, blue: 0.1412258446, alpha: 1)))
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                        
                        HStack(spacing: 3) {
                            Text(card.capRate)
                                .font(.system(size: 7))
                                .foregroundStyle(.black.opacity(0.5))
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                            Text("\(card.capRateData, specifier: "%.2f")%")
                                .font(.system(size: 7))
                                .foregroundStyle(Color(#colorLiteral(red: 0.5127275586, green: 0.7354346514, blue: 0.1412258446, alpha: 1)))
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                    }
                    
                    Button {
                        card.buttonAction()
                        
                    } label: {
                        Text("View Deal")
                            .font(.system(size: 10))
                            .minimumScaleFactor(0.5)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.champagneColor)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 30)
                    .background(Color.viewDealButtonBackgroundColor)
                    .cornerRadius(50)
                    .padding(.horizontal, 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(LinearGradient(colors: [Color(#colorLiteral(red: 0.6147011518, green: 0.1258341968, blue: 0.4036872387, alpha: 1)), Color(#colorLiteral(red: 0.8818204999, green: 0.6534648538, blue: 0.7702771425, alpha: 1))], startPoint: .leading, endPoint: .trailing), lineWidth: 0.94)
                            .padding(.horizontal, 20)
                    )
                    .shadow(color: Color.viewDealButtonShadowColor,radius: 4, x: 0, y: 1)
                    .padding(.bottom, 10)
                }
                .padding(.horizontal, 10)
            }
            .background(.white)
            .cornerRadius(10)
            .shadow(color: Color(.black).opacity(0.1), radius: 6, x: 1, y: 1)
        }
    }
}
