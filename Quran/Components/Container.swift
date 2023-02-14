//
//  Container.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct MainContainer<Content: View, Cover: View>: View {
    /**
         # My Code

         This is a brief description of my code.

         ## Usage

         To use this code, call the `myMethod` function like this:
         ```
         let result = myMethod(input)
         ```

         ## Parameters

         - `input`: The input to the `myMethod` function.

         ## Returns

         The `myMethod` function returns a result of type `Int`.

         */
    var content: Content
    var cover: Cover
    var onHidden: ()->Void
    @State var isOverlayHide: Bool = true
    @State var offset: CGFloat = 0
    @State var progess: Double = 0
    init(
        @ViewBuilder content: @escaping ()->Content,
        @ViewBuilder cover: @escaping ()->Cover,
        onHidden: @escaping ()->Void
    ){
        self.content = content()
        self.cover = cover()
        self.onHidden = onHidden
    }
    
    var body: some View {
        content
            .scaleEffect( isOverlayHide ? 1 : 0.9 )
            .blur(radius: isOverlayHide ? 0 : 30)
            .overlay{
                cover
                    .opacity(isOverlayHide ? 0 : 1)
                    .animation(.easeInOut.delay(isOverlayHide ? 0 : 0.1), value: isOverlayHide)
            }
            .environment(\.hideCoverView, hide)
            .environment(\.showCoverView, show)
    }
    
    func hide(){
        withAnimation{
            isOverlayHide = true
            onHidden()
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
        }, onHidden: {
            
        })
    }
}
