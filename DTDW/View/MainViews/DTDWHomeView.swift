//
//  HomePageNoDeals.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI
import SwiftData

struct DTDWHomeView: View {
    @State private var searchText = ""
    @State private var isGridView: Bool = true
    @Query private var properties: [PropertyData]

    @State private var isPresentingPurchaseTerms = false
    @State private var isPresentingSavedPurchaseTerms = false
    @State private var selectedProperty: PropertyData?
    @StateObject var viewModel: PurchaseTermsViewModel
    @Environment(\.modelContext) private var modelContext

    @State private var refreshToggle = false // For forcing view refresh

    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    private var filteredProperties: [PropertyData] {
        if searchText.isEmpty {
            return properties
        } else {
            return properties.filter { $0.propertyName.lowercased().contains(searchText.lowercased()) }
        }
    }

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
            DTDWPurchaseTermsMainView(propertyData: item)
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
                    isGridView.toggle()
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
                if filteredProperties.isEmpty {
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
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(filteredProperties, id: \.id) { property in
                GridCardView(card: GridCard(
                    imageName: property.imageData,
                    title: "\(property.propertyName)",
                    cashOnReturn: "Cash on Return",
                    cashOnReturnData: viewModel.cashOnCashReturn,
                    capRate: "Cap Rate",
                    capRateData: viewModel.carRateFinal,
                    buttonAction: {
                        selectedProperty = property
                        isPresentingSavedPurchaseTerms = true
                    }
                ), deleteAction: {
                    deleteProperty(property) // Call the delete logic
                })
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .padding(.bottom, 80)
    }

    private var listView: some View {
            VStack(spacing: 10) {
                ForEach(filteredProperties, id: \.id) { property in
                    SwipeableCardView(
                        card: GridCard(
                            imageName: property.imageData,
                            title: "\(property.propertyName)",
                            cashOnReturn: "Cash on Return",
                            cashOnReturnData: viewModel.cashOnCashReturn,
                            capRate: "Cap Rate",
                            capRateData: viewModel.carRateFinal,
                            buttonAction: {
                                selectedProperty = property
                                isPresentingSavedPurchaseTerms = true
                            }
                        ),
                        deleteAction: {
                            deleteProperty(property)
                        }
                    )
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 80)
            .frame(maxHeight: .infinity)
    }

    private func deleteProperty(_ property: PropertyData) {
        do {
            modelContext.delete(property)
            try modelContext.save()
            print("Deleted property: \(property)")
            refreshToggle.toggle() // Trigger a view refresh if @Query doesn't update automatically
        } catch {
            // Handle the error (e.g., show an alert)
            print("Error deleting property: \(error)")
        }
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

struct GridCard: Identifiable {
    var id = UUID()
    var imageName: Data?
    var title: String
    var cashOnReturn: String
    var cashOnReturnData: Double
    var capRate: String
    var capRateData: Double
    var buttonAction: () -> Void
}

struct GridCardView: View {
    var card: GridCard
    @State private var showingAlert = false
    @State private var cardToDelete: GridCard?
    var deleteAction: () -> Void

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                //Image...
                if let imageData = card.imageName, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(height: 112)
                } else {
                    Image("Picture")
                        .resizable()
                        .frame(height: 112)
                }
                
                //Name
                Text(card.title)
                    .font(.system(size: 11))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.black)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .padding(.horizontal, 10)
                
                
                //cash and cap
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
                .padding(.horizontal, 10)
               //Button
                Button {
                    card.buttonAction()
                } label: {
                    Text("View Deal")
                        .font(.system(size: 10))
                        .minimumScaleFactor(0.5)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.champagneColor)
                        .frame(maxWidth: .infinity, maxHeight: 30) // Ensures the text takes the full width and height
                }
                .frame(maxWidth: .infinity, maxHeight: 30) // Ensures the button has a full tappable frame
                .background(Color.viewDealButtonBackgroundColor)
                .cornerRadius(50)
                .padding(.horizontal, 20)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(LinearGradient(colors: [Color(#colorLiteral(red: 0.6147011518, green: 0.1258341968, blue: 0.4036872387, alpha: 1)), Color(#colorLiteral(red: 0.8818204999, green: 0.6534648538, blue: 0.7702771425, alpha: 1))], startPoint: .leading, endPoint: .trailing), lineWidth: 0.94)
                        .padding(.horizontal, 20)
                )
                .shadow(color: Color.viewDealButtonShadowColor, radius: 4, x: 0, y: 1)
                .padding(.bottom, 10)
                .contentShape(Rectangle()) // Ensures the entire frame is tappable
            }
            .frame(height: 208 , alignment: .top)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: Color(.black).opacity(0.1), radius: 6, x: 1, y: 1)
            .onLongPressGesture {
                showingAlert = true
                cardToDelete = card // Store the card that is being deleted
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Delete Deal"),
                    message: Text("Are you sure you want to delete this deal?"),
                    primaryButton: .destructive(Text("Delete")) {
                        deleteAction()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

struct ListCardView: View {
    var card: GridCard
    
    var body: some View {
        ZStack {
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
            .onTapGesture {
                card.buttonAction()
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

struct SwipeableCardView: View {
    var card: GridCard
    var deleteAction: () -> Void
    
    @State private var offset: CGFloat = 0
    @State private var isDeleteOptionVisible: Bool = false
    @GestureState private var isDragging = false
    
    var body: some View {
        ZStack(alignment: .trailing) {
            // Background Delete Button that only appears when dragging
            HStack {
                Spacer()
                Button {
                    deleteAction()
                } label: {
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
            }
            
            // Foreground Card View
            ListCardView(card: card)
                .offset(x: offset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if gesture.translation.width < 0 { // Swiping left
                                offset = max(gesture.translation.width, -100) // Limit swipe distance
                            }
                        }
                        .onEnded { _ in
                            if offset < -50 { // If swiped far enough, trigger delete
                                withAnimation {
                                    deleteAction()
                                }
                            } else { // Reset position if swipe is insufficient
                                withAnimation {
                                    offset = 0
                                }
                            }
                        }
                )
                .animation(.easeInOut, value: offset)
        }
    }
}
