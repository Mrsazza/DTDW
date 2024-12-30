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
    @State private var isPresentingSavedPurchaseTerms = false
    @State private var selectedProperty: PropertyData?
    @Environment(\.modelContext) private var modelContext
    @State private var newProperty: PropertyData = PropertyData(propertyName: "New Property", propertyCalculatabeleData: demoPropertyCalculatableData)
    
    var body: some View {
        ZStack {
            switch selectedTab {
            case .home:
                HomePageView()
            case .settings:
                SettingsView()
            default:
                EmptyView() // Placeholder for future tabs
            }
            
            tabBar
                .background(Color.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                .ignoresSafeArea()
                .zIndex(0)
        }
        .fullScreenCover(isPresented: $isPresentingPurchaseTerms) {
            // This opens the PurchaseTerms view with new property
            PurchaseTerms(propertyData: newProperty)
        }
    }
    
    private var tabBar: some View {
        HStack(alignment: .center) {
            tabButton(for: .home, imageNameWhite: "HomeImageWhite", imageNameBlack: "HomeImageBlack", title: "Home")
            
            plusTabButton()
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
            // Insert a new property and save it
            modelContext.insert(newProperty)
            try? modelContext.save()
            
            // Show the PurchaseTerms fullscreen
            isPresentingPurchaseTerms = true
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(Color.colorFont)
                .frame(width: 54, height: 54)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.15), radius: 2, x: 1, y: 2)
        }
    }
}


