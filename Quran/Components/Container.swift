//
//  Container.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct MainContainer<Content: View, Cover: View>: View {
    var content: Content
    var cover: Cover
    @State var isOverlayHide: Bool = true
    @State var offset: CGFloat = 0
    @State var progess: Double = 0
    init(
        @ViewBuilder content: @escaping ()->Content,
        @ViewBuilder cover: @escaping ()->Cover
    ){
        self.content = content()
        self.cover = cover()
    }
    
    var body: some View {
        ZStack{
            content
                .scaleEffect( isOverlayHide ? 1 : 1.2 )
                .blur(radius: isOverlayHide ? 0 : 30)
            cover
                .opacity(isOverlayHide ? 0 : 1)
                .animation(.easeInOut.delay(isOverlayHide ? 0 : 0.1), value: isOverlayHide)
        }
        .environment(\.hideSlideView, hide)
        .environment(\.showSlideView, show)
    }
    
    func hide(){
        withAnimation{
            isOverlayHide = true
        }
    }
    func show(){
        withAnimation{
            isOverlayHide = false
        }
    }
}

struct Custost_Previews: PreviewProvider {
    static var previews: some View {
        MainContainer(content: {
            NavigationStack{
                List{
                    
                }
                .navigationTitle("Content")
            }
        }, cover: {
            Rectangle().ignoresSafeArea()
        })
    }
}






struct HideSlideEnvKey: EnvironmentKey {
    static let defaultValue: ()->Void = {}
}
extension EnvironmentValues {
    var hideSlideView: ()->Void {
        get { self[HideSlideEnvKey.self] }
        set { self[HideSlideEnvKey.self] = newValue }
    }
}

struct ShowSlideEnvKey: EnvironmentKey {
    static let defaultValue: ()->Void = {}
}
extension EnvironmentValues {
    var showSlideView: ()->Void {
        get { self[ShowSlideEnvKey.self] }
        set { self[ShowSlideEnvKey.self] = newValue }
    }
}
