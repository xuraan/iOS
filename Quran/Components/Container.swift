//
//  Container.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-20.
//

import SwiftUI

struct Container<Content:View, Cover: View>: View {
    var content: Content
    var cover: Cover
    @State var isOverlayPresended: Bool = false
    @Environment(\.isSearching) var isSearching
    init(
        @ViewBuilder content: @escaping ()-> Content,
        @ViewBuilder cover: @escaping ()-> Cover
    ) {
        self.content = content()
        self.cover = cover()
    }
    var body: some View {
        NavigationStack{
            content
            .navigationTitle("Quran")
            .overlay(alignment: .bottomTrailing) {
                Button(action: show) {
                    Image(systemName: "book.fill")
                }
                .glassBackground(font: .title3)
                .padding(.trailing)
                .opacity(isSearching ? 0 : 1)
            }
        }
        .scaleEffect( isOverlayPresended ? 1.2 : 1)
        .blur(radius: isOverlayPresended ? 30 : 0)
        .overlay{
            cover
                .opacity(isOverlayPresended ? 1 : 0)
                .animation( isOverlayPresended ? .easeInOut.delay(0.3) : .none, value: isOverlayPresended)
        }
        .environment(\.hideCoverView, hide)
        .environment(\.showCoverView, show)
    }
    
    
    func hide(){
        withAnimation{
            isOverlayPresended = false
        }
    }
    
    func show(){
        withAnimation{
            hideKeyboard()
            isOverlayPresended = true
        }
    }
}

//MARK: - EnvKeys
struct HideCoverEnvKey: EnvironmentKey {
    static let defaultValue: ()->Void = {}
}
extension EnvironmentValues {
    var hideCoverView: ()->Void {
        get { self[HideCoverEnvKey.self] }
        set { self[HideCoverEnvKey.self] = newValue }
    }
}

struct ShowCoverEnvKey: EnvironmentKey {
    static let defaultValue: ()->Void = {}
}
extension EnvironmentValues {
    var showCoverView: ()->Void {
        get { self[ShowCoverEnvKey.self] }
        set { self[ShowCoverEnvKey.self] = newValue }
    }
}

func hideKeyboard() {
    let resign = #selector(UIResponder.resignFirstResponder)
    UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
}
