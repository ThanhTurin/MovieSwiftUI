//
//  MoviesList.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 09/06/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import SwiftUI

struct MoviesList: View {
  let movies: [Int]
  var pageListener: MoviesPagesListener?

  var body: some View {
    List {
      ForEach(movies, id: \.self) { id in
        NavigationLink(destination: MovieDetail(movieId: id)) {
          MovieRow(movieId: id)
        }
      }

      /// The pagination is done by appending a invisible rectancle at the bottom of the list, and trigerining the next page load as it appear.
      /// Hacky way for now, hope it'll be possible to find a better solution in a future version of SwiftUI.
      /// Could be possible to do with GeometryReader.
      if !movies.isEmpty {
        Rectangle()
          .foregroundColor(.clear)
          .onAppear {
            if self.pageListener != nil && !self.movies.isEmpty {
              self.pageListener?.currentPage += 1
            }
          }
      }
    }
  }
}

#if DEBUG
struct MoviesList_Previews : PreviewProvider {
  static var previews: some View {
    MoviesList(movies: [sampleMovie.id]).environmentObject(sampleStore)
  }
}
#endif
