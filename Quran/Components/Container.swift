//
//  Container.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct Container<Content:View, Overlay:View, Sheet:View>: View {
    @Binding var selectedDetent: PresentationDetent
    @Environment(\.colorScheme) var colorScheme
    @Binding var isCover: Bool
    @Binding var showSheet: Bool
    
    var content: Content
    var sheet: Sheet
    var overlay: Overlay
    
    init(
        selectedDetent: Binding<PresentationDetent>,
        isCover: Binding<Bool>,
        showSheet: Binding<Bool>,
        @ViewBuilder content: @escaping ()->Content,
        @ViewBuilder sheet: @escaping ()->Sheet,
        @ViewBuilder overlay: @escaping ()->Overlay
    ) {
        self._selectedDetent = selectedDetent
        self._isCover = isCover
        self._showSheet = showSheet
        self.content = content()
        self.sheet = sheet()
        self.overlay = overlay()
    }
    var body: some View {
        GeometryReader{proxy in
            Color.black
                .ignoresSafeArea()
        
            content
                .scrollContentBackground(.hidden)
                .background(.red)
                .overlay(alignment: .bottomTrailing){
                    Button{
                        withAnimation{
                            isCover = true
                            showSheet = false
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

                .frame(height: proxy.size.height+proxy.safeAreaInsets.top-proxy.safeAreaInsets.bottom-15)
                .cornerRadius(12)
                .ignoresSafeArea()
                .scaleEffect(isCover ? 1.2 : 1)
            
                .sheet(isPresented: $showSheet){
                    sheet
                        
                    .presentationDetents(isCover ? [.large] : [.height(12+proxy.safeAreaInsets.bottom), .large], selection: $selectedDetent)
                    .interactiveDismissDisabled(!isCover)
                    .presentationDragIndicator( selectedDetent != .large ? .hidden : .visible)
                    .onAppear{
                        guard let windows = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
                            return
                        }

                        if let controller =  windows.windows.first?.rootViewController?
                            .presentedViewController, let sheet = controller.presentationController as? UISheetPresentationController{
                        // MARK: As Usual Set Properties What Ever Your Wish Here With Sheet
                        
                            controller.presentingViewController?.view.tintAdjustmentMode = .normal
                            sheet.largestUndimmedDetentIdentifier = .large
                            sheet.preferredCornerRadius = 12
                        }else{
                        print ("NO CONTROLLER FOUND" )
                        }
                    }
                    .blur(radius: selectedDetent != .large ? 30 : 0)
                    .overlay{
                        Text("Index")
                            .offset(y: proxy.safeAreaInsets.bottom/3)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("bg"))
                            .font(.title3)
                            .fontWeight(.semibold)
                            .opacity(selectedDetent == .large ? 0 : 1)
                            .onTapGesture {
                                if selectedDetent != .large {
                                    selectedDetent = .large
                                }
                            }
                    }
                }
                .onChange(of: isCover){ value in
                    if !value {
                        selectedDetent = .height(12+proxy.safeAreaInsets.bottom)
                    } else {
                        selectedDetent = .large
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
                        showSheet = true
                    }
                })
                .padding(.horizontal)
            })
            .opacity(isCover ? 1 : 0)
        }
        .ignoresSafeArea(.keyboard)
    }
}

