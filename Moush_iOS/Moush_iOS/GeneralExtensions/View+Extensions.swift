//
//  View+Extensions.swift
//  Moush_iOS
//
//  Created by The Odd Institute on 2023-05-11.
//

import SwiftUI

extension View {
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }

    func embedInScrollView() -> some View {
        ScrollView { self }
    }
}
