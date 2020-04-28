//
//  MoviesHome.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 22/06/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import SwiftUI
import Combine
import SwiftUIFlux

struct MoviesHome : View {
  @EnvironmentObject private var store: Store<AppState>
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

  private var homeAsList: some View {
    Group {
      MoviesHomeList(
        menu: $selectedMenu.menu,
        pageListener: selectedMenu.pageListener,
        headerView: nil
      )
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
    let view = Group {
      homeAsList
    }
    .navigationBarItems(trailing:
      HStack {
        settingButton
      }
    ).sheet(isPresented: $isSettingPresented, content: { SettingsForm()
    })
    return navigationView(content: AnyView(view))
  }
}

#if DEBUG
struct MoviesHome_Previews : PreviewProvider {
  static var previews: some View {
    MoviesHome().environmentObject(sampleStore)
  }
}
#endif
