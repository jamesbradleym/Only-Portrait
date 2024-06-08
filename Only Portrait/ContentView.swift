//
//  ContentView.swift
//  Only Portrait
//
//  Created by James Bradley on 6/8/24.
//

import SwiftUI
import SwiftData

import UIKit

struct ContentView: View {
    var body: some View {
        ZStack {
            FreeView()
            OnlyPortraitView()
        }
        .background(.black)
    }
}

struct FreeView: View {
    var body: some View {
        Text("FreeView")
            .padding()
    }
}

struct OnlyPortraitView: View {
    var body: some View {
        VStack {
            Text("OnlyPortraitView")
                .padding()
            Text("This view is locked to portrait orientation")
                .foregroundColor(.blue)
                .padding()
        }
        .lockOrientation(.portrait)
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    var orientationLock = UIInterfaceOrientationMask.all

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationLock
    }

    struct AppUtility {
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = orientation
                delegate.updateSupportedInterfaceOrientations()
            }
        }

        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation: UIInterfaceOrientation) {
            lockOrientation(orientation)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: orientation)) { error in
                        print("Error requesting geometry update: \(error.localizedDescription)")
                }
            }
        }
    }

    private func updateSupportedInterfaceOrientations() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController?.setNeedsUpdateOfSupportedInterfaceOrientations()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
