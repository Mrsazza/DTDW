//
//  HomePageNoDeals.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI
import SwiftData

struct HomePageView: View {
    @State private var searchText = ""
    @State private var isGridView: Bool = true
    @Query private var properties: [PropertyData]

    @State private var isPresentingPurchaseTerms = false
    @State private var isPresentingSavedPurchaseTerms = false
    @State private var selectedProperty: PropertyData?
    @StateObject var viewModel: PurchaseTermsViewModel

    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        ZStack {
            Color.mainBackgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Header Section
                headerSection

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
                    yourDealsSection
                }
                .background(.white)
                .clipShape(RoundedCornerShape(corners: [.topLeft, .topRight], radius: 20))
                .padding(.horizontal, 15)
                .shadow(color: Color.blackOnePercentColor, radius: 4, x: 2, y: 0)
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        .fullScreenCover(item: $selectedProperty, onDismiss: {
            selectedProperty = nil
        }) { item in
            PurchaseTermsMainView(propertyData: item)
        }
    }

    private var headerSection: some View {
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
    }

    private var yourDealsSection: some View {
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
                if properties.isEmpty {
                    noDealsView
                } else {
                    if isGridView {
                        gridView
                    } else {
                        listView
                    }
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

    private var noDealsView: some View {
        VStack(spacing: 8) {
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
        .padding(.top, 120)
    }

    private var gridView: some View {
        LazyVGrid(columns: columns, spacing: 25) {
            ForEach(properties, id: \.id) { property in
                GridCardView(card: GridCard(
                    imageName: "Picture",
                    title: "\(property.propertyName)",
                    cashOnReturn: "Cash on Return",
                    cashOnReturnData: viewModel.cashOnCashReturn,
                    capRate: "Cap Rate",
                    capRateData: property.propertyCalculatabeleData.capRate ?? 0.0,
                    buttonAction: {
                        selectedProperty = property
                        isPresentingSavedPurchaseTerms = true
                    }
                ))
            }
        }
        .onAppear {
            viewModel.updateMetrics(for: viewModel.propertyData)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 80)
    }

    private var listView: some View {
        VStack(spacing: 10) {
            ForEach(properties, id: \.id) { property in
                ListCardView(card: GridCard(
                    imageName: "Picture",
                    title: "\(property.propertyName)",
                    cashOnReturn: "Cash on Return", // Can stay as a String
                    cashOnReturnData:  viewModel.cashOnCashReturn, // Pass as Double
                    capRate: "Cap Rate", // Can stay as a String
                    capRateData: viewModel.capRate, // Pass as Double
                    buttonAction: {
                        selectedProperty = property
                        isPresentingSavedPurchaseTerms = true
                    }
                ))
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 80)
    }


    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
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
