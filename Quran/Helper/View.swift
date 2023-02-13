//
//  View.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

extension View{
    @ViewBuilder
    func mequran(_ size: CGFloat)->some View{
        self.font(.custom("me_quran", size: size))
    }
    @ViewBuilder
    func amiri(_ size: CGFloat)->some View{
        self.font(.custom("AmiriQuran-Regular", size: size))
    }
    @ViewBuilder
    func waseem(_ size: CGFloat, weight: Font.Weight = .regular)->some View{
        self.font(.custom("Waseem", size: size))
            .fontWeight(weight)
    }
    @ViewBuilder
    func offset(coordinateSpace: CoordinateSpace, completion: @escaping(CGRect)->()) -> some View {
        self
            .overlay{
                GeometryReader{ proxy in
                    let minY = proxy.frame(in: coordinateSpace).minY
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                        .onPreferenceChange(OffsetKey.self){ value in
                            completion(proxy.frame(in: coordinateSpace))
                        }
                }
            }
    }
    
    var contentBG: some View {
        self
        .scrollContentBackground(.hidden)
        .background(Color("bg"))
    }
    
    @ViewBuilder
    func customSheet<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View{
        self
            .sheet(isPresented: isPresented){
                content()
                    .onAppear{
                        guard let windows = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
                            return
                        }
                        if let controller =  windows.windows.first?.rootViewController?
                            .presentedViewController, let sheet = controller.presentationController as? UISheetPresentationController{
                        // MARK: As Usual Set Properties What Ever Your Wish Here With Sheet
                            sheet.preferredCornerRadius = 30
                        }
                    }
            }
    }
    
    @ViewBuilder
    func customDismissibleSheet<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View{
        self
            .sheet(isPresented: isPresented){
                NavigationStack{
                    content()
                        .toolbar{
                            CloseButton()
                        }
                        .onAppear{
                            guard let windows = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
                                return
                            }
                            if let controller =  windows.windows.first?.rootViewController?
                                .presentedViewController, let sheet = controller.presentationController as? UISheetPresentationController{
                            // MARK: As Usual Set Properties What Ever Your Wish Here With Sheet
                                sheet.preferredCornerRadius = 30
                            }
                        }
                }
                
            }
    }

    @ViewBuilder
    var fullSeparatore: some View {
        self.alignmentGuide(.listRowSeparatorLeading){ viewDimension in
            return -viewDimension[.listRowSeparatorLeading]
        }
    }
    @ViewBuilder
    var fullSeparatore2: some View {
        self.alignmentGuide(.listRowSeparatorLeading){ viewDimension in
            return -(viewDimension[.leading]+17)
        }
    }
}
