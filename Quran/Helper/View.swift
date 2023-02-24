//
//  View.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

extension View {
    @ViewBuilder
    var fullSeparatoreListPlain: some View {
        self.alignmentGuide(.listRowSeparatorLeading){ viewDimension in
            return -(viewDimension[.leading]+17)
        }
    }
    
    @ViewBuilder
    var fullSeparatoreWhenEdgeInset0: some View {
        self.alignmentGuide(.listRowSeparatorLeading){ viewDimension in
            return -viewDimension[.leading]
        }
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
    
    @ViewBuilder
         func roundedSheet<Content: View>(
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
                                 //controller.presentingViewController?.view.tintAdjustmentMode = .normal
                                 //sheet.largestUndimmedDetentIdentifier = .large
                                 sheet.preferredCornerRadius = 30
                             }
                         }

                 }
         }
    
    @ViewBuilder
    func glassBackground(font: Font = .headline.bold(), color: Color = .accentColor, size: Double = 12, in shape: any Shape = Circle()) -> some View {
        self
            .font(font)
            .foregroundColor(color)
            .padding(size)
            .background {
                AnyShape(shape)
                    .fill(.ultraThinMaterial.shadow(.inner(color: color.opacity(0.3), radius: 5)))
            }
            .padding(-1)
            .clipShape(AnyShape(shape))
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
