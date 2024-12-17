//
//  DTDWTabView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 11/11/24.
//

import SwiftUI
import SwiftData

enum Tab {
    case home
    case plus
    case settings
}

struct DTDWTabView: View {
    @State private var selectedTab: Tab = .home
    @State private var isPresentingPurchaseTerms = false
    @Environment(\.modelContext) private var modelContext
    @State private var newProperty: PropertyData = PropertyData(propertyName: "New Property", propertyCalculatabeleData: demoPropertyCalculatableData)
    @State private var propertyID: String?
    
    var body: some View {
        ZStack {
            switch selectedTab {
            case .home:
                HomePageView()
                   
            case .settings:
                SettingsView()
                
            default:
                EmptyView() //Placeholder, since PurchaseTerms is shown as a full screen cover
            }
            
            tabBar
                .background(Color.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.01)),radius: 4, x: 0, y: -1)
                .ignoresSafeArea()
                .zIndex(0)
        }
        .fullScreenCover(isPresented: $isPresentingPurchaseTerms) {
            if let newProp = modelContext.model(for: newProperty.persistentModelID) as? PropertyData {
                    PurchaseTerms(propertyData: newProp)
            }
        }
    }
    
    private var tabBar: some View {
        HStack(alignment: .center) {
            tabButton(for: .home, imageNameWhite: "HomeImageWhite", imageNameBlack: "HomeImageBlack", title: "Home")
            
            plusTabButton() // Use a separate button view for the 'plus' tab
                .padding(.bottom, 10)
            
            tabButton(for: .settings, imageNameWhite: "SettingsImageWhite", imageNameBlack: "SettingsImageBlack", title: "Settings")
        }
        .frame(height: 90)
    }
    
    private func tabButton(for tab: Tab, imageNameWhite: String, imageNameBlack: String, title: String) -> some View {
        Button {
            selectedTab = tab
        } label: {
            let isActive = selectedTab == tab && selectedTab != .plus
            CustomTabButton(imageNameWhite: imageNameWhite, imageNameBlack: imageNameBlack, tabText: title, isActive: isActive)
        }
        .tint(Color.white)
    }
    
    private func plusTabButton() -> some View {
        Button {
            modelContext.insert(newProperty)
            try? modelContext.save()
            isPresentingPurchaseTerms = true // Show full screen cover when tapped
           
            
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(Color.colorFont)
                .frame(width: 54, height: 54)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15)),radius: 2, x: 1, y: 2)
        }
    }
}
