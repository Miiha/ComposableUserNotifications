//
//  ContentView.swift
//  Example
//
//  Created by Michael Kao on 31.10.20.
//

import ComposableArchitecture
import ComposableUserNotifications
import SwiftUI

struct ContentView: View {
  let store: Store<AppState, AppAction>

  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack {
        Text("Count: \(viewStore.count ?? 0)")
          .padding()
        Button("Schedule notification") {
          viewStore.send(.tappedScheduleButton)
        }
      }
    }
  }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(
      store: Store(
        initialState: AppState(),
        reducer: .empty,
        environment: AppEnvironment(
          remoteClient: RemoteClient(fetchRemoteCount: { Effect(value: 1) }),
          userNotificationClient: .mock()
        )
      )
    )
  }
}
#endif
