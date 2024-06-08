//
//  OrientationLock.swift
//  Only Portrait
//
//  Created by James Bradley on 6/8/24.
//

import SwiftUI

class PortraitHostingController<Content>: UIHostingController<Content> where Content: View {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

    }
    
    @objc func orientationDidChange(_ notification: Notification) {
        // Handle the orientation change
        // Useful for more specific reactions to orientation changes
    }
}

// View Modifier to Lock Orientation
struct LockOrientationModifier: ViewModifier {
    let orientation: UIInterfaceOrientationMask

    func body(content: Content) -> some View {
        OrientationHostingView(orientation: orientation, content: content)
    }
}

// UIViewControllerRepresentable to Host SwiftUI Content and Enforce Orientation
struct OrientationHostingView<Content: View>: UIViewControllerRepresentable {
    let orientation: UIInterfaceOrientationMask
    let content: Content

    func makeUIViewController(context: Context) -> UIViewController {
        if orientation == .portrait {
            return PortraitHostingController(rootView: content)
        } else {
            return UIHostingController(rootView: content)
        }
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

extension View {
    func lockOrientation(_ orientation: UIInterfaceOrientationMask) -> some View {
        self.modifier(LockOrientationModifier(orientation: orientation))
    }
}
