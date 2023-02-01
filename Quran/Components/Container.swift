//
//  Container.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

extension PresentationDetent {
    static var float: PresentationDetent{
        return .height(23)
    }
    
    static var hide: PresentationDetent{
        return .height(-40)
    }
    
    var isLarge: Bool { self == .large }
    var isHide: Bool { self == .hide }
    var isFloat: Bool { self == .float }    
}


struct Container<Content:View, Overlay:View, Sheet:View>: View {
    @Binding var selectedDetent: PresentationDetent
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.safeArea) var safeArea
    @Binding var isCover: Bool
    @Binding var hideCloseButton: Bool
    var content: Content
    var sheet: Sheet
    var overlay: Overlay
    
    init(
        selectedDetent: Binding<PresentationDetent>,
        isCover: Binding<Bool>,
        isHideCloseButton: Binding<Bool>,
        @ViewBuilder content: @escaping ()->Content,
        @ViewBuilder sheet: @escaping ()->Sheet,
        @ViewBuilder overlay: @escaping ()->Overlay
    ) {
        self._selectedDetent = selectedDetent
        self._isCover = isCover
        self.content = content()
        self.sheet = sheet()
        self.overlay = overlay()
        self._hideCloseButton = isHideCloseButton
    }
    var body: some View {
        GeometryReader{proxy in
            Color.black
                .ignoresSafeArea()
        
            content
                .overlay(alignment: .bottomTrailing){
                    Button{
                        withAnimation{
                            isCover = true
                        }
                    } label: {
                        Image(systemName: "book.fill")
                            .padding(15)
                            .font(.title3)
                            .foregroundColor(colorScheme != .dark ? .white : .black)
                            .background{
                                Circle()
                                    .fill(colorScheme == .dark ? .white : .black)
                            }
                            .offset(y: -10)
                            .offset(x: -5)
                    }
                }

                .frame(height: proxy.size.height+proxy.safeAreaInsets.top-24)
                .cornerRadius(10)
                .scaleEffect(isCover ? 1.2 : 1)
                .ignoresSafeArea()

                .sheet(isPresented: .constant(true)){
                    sheet
                        .presentationDetents(isCover ? [.hide, .large] : [.float, .large], selection: $selectedDetent)
                    .interactiveDismissDisabled(!isCover)
                    .presentationDragIndicator( selectedDetent == .large ? .hidden : .visible)
                    .onAppear{
                        guard let windows = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
                            return
                        }

                        if let controller =  windows.windows.first?.rootViewController?
                            .presentedViewController, let sheet = controller.presentationController as? UISheetPresentationController{
                        // MARK: As Usual Set Properties What Ever Your Wish Here With Sheet
                        
                            controller.presentingViewController?.view.tintAdjustmentMode = .normal
                            sheet.largestUndimmedDetentIdentifier = .large
                            sheet.preferredCornerRadius = 10
                        }else{
                            print ("NO CONTROLLER FOUND" )
                        }
                    }
                    
                }
                .onChange(of: isCover){ value in
                    withAnimation{
                        if !value {
                            selectedDetent = .float
                        } else {
                            selectedDetent = .hide
                        }
                    }
                }
        }
        .blur(radius: isCover ? 30 : 0)
        .overlay{
            overlay
            .overlay(alignment: .topTrailing, content: {
                CloseButton(action: {
                    withAnimation{
                        isCover = false
                    }
                })
                .padding(.horizontal)
                .opacity(hideCloseButton ? 0 : 1)
            })
            .opacity(isCover ? 1 : 0)
            .animation(.easeInOut.delay(isCover ? 0.2 : -1), value: isCover)
        }
        .ignoresSafeArea(.keyboard)

    }
}

