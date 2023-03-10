//
//  SheetButton.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-20.
//

import SwiftUI

struct NavigationButtomSheet: View {
    var content: AnyView
    var label: AnyView?
    var closeButtonTitle: String?
    var closeButtonSystemName: String?
    var title: String?
    var presentationDetents: Set<PresentationDetent>?
    @State var show = false
    init<Content: View, Label: View>(
        @ViewBuilder content: @escaping ()-> Content,
        @ViewBuilder label: @escaping ()-> Label
        
    ) {
        self.content = AnyView(content())
        self.label = AnyView(label())
    }
    init<Content: View, Label: View>(
        closeButtonTitle: String = "Done",
        presentationDetents: Set<PresentationDetent> = .init([.large]),
        @ViewBuilder content: @escaping ()-> Content,
        @ViewBuilder label: @escaping ()-> Label
    ) {
        self.content = AnyView(content())
        self.label = AnyView(label())
        self.closeButtonTitle = closeButtonTitle
        self.presentationDetents = presentationDetents
    }
    init<Content: View, Label: View>(
        closeButtonSystemName: String = "xmark",
        presentationDetents: Set<PresentationDetent> = .init([.large]),
        @ViewBuilder content: @escaping ()-> Content,
        @ViewBuilder label: @escaping ()-> Label
    ) {
        self.content = AnyView(content())
        self.label = AnyView(label())
        self.closeButtonSystemName = closeButtonSystemName
        self.presentationDetents = presentationDetents
    }
    init<Content: View>(
        _ title: String,
        closeButtonTitle: String = "Done",
        presentationDetents: Set<PresentationDetent> = .init([.large]),
        @ViewBuilder content: @escaping ()-> Content
    ) {
        self.title = title
        self.content = AnyView(content())
        self.closeButtonTitle = closeButtonTitle
        self.presentationDetents = presentationDetents
    }
    init<Content: View>(
        title: String,
        closeButtonSystemName: String = "xmark",
        presentationDetents: Set<PresentationDetent> = .init([.large]),
        @ViewBuilder content: @escaping ()-> Content
    ) {
        self.title = title
        self.content = AnyView(content())
        self.closeButtonSystemName = closeButtonSystemName
        self.presentationDetents = presentationDetents
    }
    var body: some View {
        Button(action: {show = true}){
            if let title = title {
                Text(LocalizedStringKey(title))
            } else if let label = label {
                label
            }
        }
        .roundedSheet(isPresented: $show){
            NavigationStack{
                content
                    .toolbar{
                        ToolbarItem(placement: .destructiveAction, content: {
                            if let imageName = closeButtonSystemName {
                                CloseButton(icon: Image(systemName: imageName))
                            } else if let title = closeButtonTitle {
                                Button(title){
                                    withAnimation{
                                        show.toggle()
                                    }
                                }
                            } else {
                                CloseButton()
                            }
                        })
                    }
            }
            .presentationDetents(presentationDetents != nil ? presentationDetents! : .init([.large]))        }
    }
}

struct SheetButton: View {
    var content: AnyView
    var label: AnyView?
    var title: String?
    @State var show = false
    init<Content: View, Label: View>(
        @ViewBuilder content: @escaping ()-> Content,
        @ViewBuilder label: @escaping ()-> Label
        
    ) {
        self.content = AnyView(content())
        self.label = AnyView(label())
    }
    init<Content: View>(
        _ title: String,
        @ViewBuilder content: @escaping ()-> Content
    ) {
        self.title = title
        self.content = AnyView(content())
    }
    var body: some View {
        Button(action: {show = true}){
            if let title = title {
                Text(LocalizedStringKey(title))
            } else if let label = label {
                label
            }
        }
        .roundedSheet(isPresented: $show){
            content
        }
        
    }
}
