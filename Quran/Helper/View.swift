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
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
