//
//  HomePageNoDeals.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI

struct HomePageView: View {
    @State private var searchText = ""
    @State private var isGridView: Bool = true
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    // Example deal data count (replace with actual data logic)
    private let dealCount = 8
    
    var body: some View {
        ZStack {
            Color.mainBackgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // Header Section
                HStack(spacing: 50) {
                    Image("Logo-3")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 55, height: 52)
                    
                    VStack {
                        Text("Does The Deal Work?")
                            .foregroundStyle(Color(#colorLiteral(red: 0.6821199059, green: 0.2117495537, blue: 0.475467205, alpha: 1)))
                        
                        Text("Ask the Land Lady®")
                            .foregroundStyle(Color.black)
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                // Divider
                RoundedRectangle(cornerRadius: 20)
                    .frame(maxWidth: .infinity, maxHeight: 2)
                    .foregroundStyle(Color(#colorLiteral(red: 0.6821199059, green: 0.2117495537, blue: 0.475467205, alpha: 0.15)))
                
                VStack(spacing: 20) {
                    // Title Section
                    Text("Real Estate Analysis")
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    // Search bar
                    SearchBar(text: $searchText)
                    
                    // Your Deals Section
                    VStack(spacing: 5) {
                        HStack {
                            Text("Your Deals")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            // Grid or List Button
                            Button {
                                withAnimation(.easeInOut) {
                                    isGridView.toggle()
                                }
                            } label: {
                                Image(systemName: isGridView ? "list.bullet" : "square.grid.2x2")
                                    .font(.system(size: 21))
                                    .foregroundStyle(.black)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // Divider
                        RoundedRectangle(cornerRadius: 20)
                            .frame(maxWidth: .infinity, maxHeight: 2)
                            .foregroundStyle(Color(#colorLiteral(red: 0.6821199059, green: 0.2117495537, blue: 0.475467205, alpha: 0.15)))
                            .padding(.horizontal, 20)
                            .padding(.top, 5)
                        
                        // Grid or List View based on toggle, or "No Deals" message if no deals available
                        ScrollView(showsIndicators: false) {
                            if dealCount > 0 {
                                if isGridView {
                                    LazyVGrid(columns: columns, spacing: 25) {
                                        ForEach(0..<dealCount, id: \.self) { index in
                                            GridCardView(card: GridCard(
                                                imageName: "Picture",
                                                title: "Land lady apartment on set.",
                                                cashOnReturn: "Cash on Return 11.52%",
                                                capRate: "Cap Rate 8.99%",
                                                buttonAction: {
                                                    print("View Deal")
                                                }
                                            ))
                                        }
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.top, 20)
                                    .padding(.bottom, 80)
                                } else {
                                    VStack(spacing: 10) {
                                        ForEach(0..<dealCount, id: \.self) { index in
                                            ListCardView(card: GridCard(
                                                imageName: "Picture",
                                                title: "Land lady apartment on set.",
                                                cashOnReturn: "Cash on Return 11.52%",
                                                capRate: "Cap Rate 8.99%",
                                                buttonAction: {
                                                    print("View Deal")
                                                }
                                            ))
                                        }
                                    }
                                    .padding(.top, 20)
                                    .padding(.bottom, 80)
                                }
                            } else {
                                VStack {
                                    Image("Property Icon")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 42, height: 42)
                                    Text("No Deals")
                                        .fontWeight(.bold)

                                    Text("You haven’t added any deals yet")
                                }
                                .padding(.top, 100)
                            }
                        }
                    }
                }
                .background(.white)
                .clipShape(RoundedCornerShape(corners: [.topLeft, .topRight], radius: 20))
                .padding(.horizontal, 15)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 0)
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}



#Preview {
    HomePageView()
}

struct RoundedCornerShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
