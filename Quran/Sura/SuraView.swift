//
//  SuraView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SuraView: View {
    @ObservedObject var sura: Sura
    @EnvironmentObject var suraVM: SuraViewModel
    @State var rect: CGRect = .zero
    @State var lastOffsetY: CGFloat = .zero
    @State var isExpanded: Bool = false
    var titleAction: ()->Void
    @State var titleId = UUID()
    init(for sura: Sura, _ titleAction: @escaping ()->Void = {}) {
        self.sura = sura
        self.titleAction = titleAction
    }
    
    var body: some View {
        GeometryReader{ proxy in
            ScrollViewReader{ scroll in
                ScrollView{
                    LazyVStack{
                        if sura.id != 9 {
                            Text("﷽")
                                .mequran(40)
                                .frame(maxWidth: .infinity)
                        }
                        ForEach(sura.ayas.toAyas){ aya in
                            if aya == aya.sofha.ayas.toAyas.first {
                                AyaView(for: aya)
                                    .offset(coordinateSpace: .global){ value in
                                        if (100...150).contains(value.minY){
//                                            setCurrentAya(aya.id)
                                        }
                                    }
                            } else {
                                AyaView(for: aya)
                            }
                            pageSeparator(aya: aya)
                        }
                        
                    }
                    .padding(.top, 30)
                    .offset(coordinateSpace: .named("sura\(sura.id)")){ value in
                        DispatchQueue.main.async {
                            withAnimation{
                                if rect.minY >= -10 {
                                    if isExpanded {
                                        isExpanded = false
                                    }
                                } else {
                                    if !isExpanded {
                                        isExpanded = true
                                    }
                                }
                                
                            }
                            rect = value
                        }
                    }
                }
                .safeAreaInset(edge: .top){
                    HStack{
                        VStack(alignment: .leading){
                            Text(sura.phonetic)
                                .font(.footnote)
                            Text(sura.translation).font(.caption)
                        }.lineLimit(1).foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(isExpanded ? 1 : 0)
                        
                        Button(action: titleAction){
                            Text(sura.name)
                                .waseem(35, weight: .regular)
                                .padding(.vertical, -10)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .lineLimit(1)
                                .minimumScaleFactor(0.1)
                                .contentTransition(.interpolate)
                        }.id(titleId)
                        VStack(alignment: .trailing){
                            Text(LocalizedStringKey(sura.place.id))
                                .font(.caption)
                            Text("ayas: \(sura.ayas.toAyas.count)").font(.caption)
                        }
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .padding(.trailing, 50+proxy.safeAreaInsets.trailing)
                        .opacity(isExpanded ? 1 : 0)
                        .frame(maxWidth: .infinity, alignment: .trailing)

                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background{
                        Rectangle().fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                            .overlay(alignment: .bottom){
                                Divider()
                            }
                            .opacity(isExpanded ? 1 : 0)
                            .animation(isExpanded ? .none : .easeInOut, value: isExpanded)
                    }
                }
                .coordinateSpace(name: "sura\(sura.id)")
//                .onChange(of: scrollTo){ value in
//                    if value != nil {
//                        withAnimation{
//                            scroll.scrollTo(value, anchor: .top)
//                        }
//                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now()+1){
//                        withAnimation{
//                            scrollTo = nil
//                        }
//                    }
//                }
//                .onAppear{
//                    if scrollTo != nil {
//                        withAnimation{
//                            scroll.scrollTo(scrollTo, anchor: .top)
//                        }
//                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now()+1){
//                        withAnimation{
//                            scrollTo = nil
//                        }
//                    }
//                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
                    titleId = UUID()
                })
            }
        }
    }
    
    @ViewBuilder
    func pageSeparator(aya: Aya) -> some View {
        if aya == aya.sofha.ayas.toAyas.last {
            HStack{
                VStack{
                    Divider()
                }
                Text("\(aya.sofha.id)")
                    .font(.footnote)
                VStack{
                    Divider()
                }
            }
            .offset(y: 5)
        }
    }
}
