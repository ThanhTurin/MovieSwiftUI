//
//  MoviesHome.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 22/06/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import SwiftUI
import Combine

struct MoviesHome: View {

  @ObservedObject private var selectedMenu = MoviesSelectedMenuStore(selectedMenu: MoviesMenu.allCases.first!)
  @State private var isSettingPresented = false

  private var settingButton: some View {
    Button(action: {
      self.isSettingPresented = true
    }) {
      HStack {
        Image(systemName: "wrench").imageScale(.medium)
      }.frame(width: 30, height: 30)
    }
  }

  private func navigationView(content: AnyView) -> some View {
    Group {
      NavigationView {
        content
      }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
  }

  var body: some View {
    let view = MoviesHomeList(menu: $selectedMenu.menu, pageListener: selectedMenu.pageListener)
    .navigationBarItems(trailing: settingButton)
    .sheet(isPresented: $isSettingPresented, content: { SettingsForm() })

    return navigationView(content: AnyView(view))
  }
}

#if DEBUG
struct MoviesHome_Previews: PreviewProvider {
  static var previews: some View {
    MoviesHome().environmentObject(sampleStore)
  }
}
#endif
