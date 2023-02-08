//
//  Container.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct ContainerBeta<Content: View, Slide: View>: View {
    var content: Content
    var slide: Slide
    @GestureState private var dragState = DragState.inactive
    @State var offset: CGFloat = 0
    @State var progess: Double = 0
    init(
        @ViewBuilder content: @escaping ()->Content,
        @ViewBuilder slide: @escaping ()->Slide
    ){
        self.content = content()
        self.slide = slide()
    }
    
    var body: some View {
        GeometryReader{ proxy in
            ZStack{
                content
                    .scaleEffect( progess != 0 ? 1+progess*0.001 : 1  )
                    .blur(radius: progess)
                    .simultaneousGesture(DragGesture().updating($dragState, body: { (value, state, transaction) in
                        state = .dragging(translation: value.translation)
                    }).onEnded{ value in
                        if -value.translation.width > proxy.size.width/2 || -value.predictedEndTranslation.width > proxy.size.width/2 {
                            show()
                        } else {
                            withAnimation{
                                offset = proxy.size.width
                                progess = 0
                            }
                        }
                    })
                    .onChange(of: dragState.translation){ value in
                        if value.width <= 0 && offset != 0 {
                            offset = proxy.size.width+value.width
                            progess =  -value.width*0.05
                        }
                    }
                slide
                    .offset(x: offset)
            }
            .onAppear{
                offset = proxy.size.width
            }
            .environment(\.hideSlideView, {hide(offset: proxy.size.width+proxy.safeAreaInsets.trailing)})
            .environment(\.showSlideView, show)
        }
    }
    
    func hide(offset: CGFloat){
        withAnimation{
            self.offset = offset
            self.progess = 0
        }
    }
    func show(){
        withAnimation{
            self.offset = 0
            self.progess = 30
        }
    }
}


enum DragState {
    case inactive
    case pressing
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
}
struct Custost_Previews: PreviewProvider {
    static var previews: some View {
        ContainerBeta(content: {
            NavigationStack{
                List{
                    
                }
                .navigationTitle("Content")
            }
        }, slide: {
            Rectangle()
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
