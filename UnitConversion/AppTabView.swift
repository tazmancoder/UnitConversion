//
//  AppTabView.swift
//  UnitConversion
//
//  Created by Mark Perryman on 5/11/22.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            NavigationView { TemperatureConversionView() }
                .tabItem {
                    Label("Temperature", systemImage: "thermometer")
                }
            NavigationView { LengthConversionView() }
                .tabItem {
                    Label("Length", systemImage: "ruler")
                }
            NavigationView { }
                .tabItem {
                    Label("Time", systemImage: "clock")
                }
            NavigationView { }
                .tabItem {
                    Label("Volume", systemImage: "takeoutbag.and.cup.and.straw")
                }
        }
        .navigationViewStyle(.stack)
        .accentColor(Color.themeBlue)
        .onAppear(perform: {
            // MDK01-15-22 -- This fixes the issue with the tab view going transparent
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)

            // Use this appearance when scrolling behind the TabView
            UITabBar.appearance().standardAppearance = appearance

            // Use this appearance when scrolled all the way up
            UITabBar.appearance().scrollEdgeAppearance = appearance

            // Correct issue with navigation bar as well
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            navBarAppearance.backgroundColor = UIColor(Color.themeBlue.opacity(Constants.pt2))
            // Leave this in, just in case I decide to change the font color of the nav bar
            // Use this if NavigationBarTitle is with Large Font
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            // Use this if NavigationBarTitle is with displayMode = .inline
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]

            // Use this appearance when scrolling behind the NavBar
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            // Use this appearance when scrolled all the way down
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        })

    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
