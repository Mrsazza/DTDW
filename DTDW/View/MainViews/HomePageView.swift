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
                HStack(spacing: 20) {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 55, height: 52)
                    
                    VStack {
                        Text("Does The Deal Work?")
                            .foregroundStyle(Color.deepPurpelColor)
                            .font(.system(size: 18))
                        
                        Text("Ask the Land Lady®")
                            .font(.system(size: 24))
                            .foregroundStyle(Color.black)
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                // Divider
                RoundedRectangle(cornerRadius: 20)
                    .frame(maxWidth: .infinity, maxHeight: 2)
                    .foregroundStyle(Color.colorDivider)
                
                VStack(spacing: 20) {
                    // Title Section
                    Text("Real Estate Analysis")
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    // Search bar
                    SearchBar(text: $searchText)  
                    
                    // Your Deals Section
                    VStack(spacing: 5) {
                        HStack {
                            Text("Your Deals")
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
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
                            .foregroundStyle(Color.colorDivider)
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
                                        .font(.system(size: 20))
                                        .foregroundStyle(.black)
                                    Text("You haven’t added any deals yet")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.black)
                                }
                                .padding(.top, 100)
                            }
                        }
                        .padding(.bottom, 30)
                    }
                    .background(
                        Color.clear
                            .contentShape(Rectangle())
                            .onTapGesture {
                                hideKeyboard()
                            }
                    )
                }
                .background(.white)
                .clipShape(RoundedCornerShape(corners: [.topLeft, .topRight], radius: 20))
                .padding(.horizontal, 15)
                .shadow(color: Color.blackOnePercentColor, radius: 4, x: 2, y: 0)
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
