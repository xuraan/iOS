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
    @EnvironmentObject var quranVM: QuranViewModel
    @State var rect: CGRect = .zero
    @State var lastOffsetY: CGFloat = .zero
    @State var isExpanded: Bool = false
    @State var scrollTo: Aya.ID?
    var titleAction: ()->Void
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
                            Group{
                                if aya == aya.sofha.ayas.toAyas.first {
                                    AyaView(for: aya)
//                                        .offset(coordinateSpace: .global){ value in
//                                            if (100...150).contains(value.minY){
//                                                
//                                            }
//                                        }
                                } else {
                                    AyaView(for: aya)
                                }
                            }
                            .background(Color.blue.opacity( aya.id == scrollTo ? 1 : 0).blur(radius: 20))
                            pageSeparator(aya: aya)
                        }
                    }
                    .padding(.top, -20)
                    .offset(coordinateSpace: .named("sura\(sura.id)")){ value in
                        DispatchQueue.main.async {
                            withAnimation{
                                if rect.minY >= -20 {
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
                .coordinateSpace(name: "sura\(sura.id)")
                .safeAreaInset(edge: .top){
                    HStack{
                        VStack(alignment: .leading){
                            Text(sura.phonetic)
                                .font(.footnote)
                            Text(sura.translation).font(.caption)
                        }.lineLimit(1).foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(isExpanded ? 1 : 0)
                        
                        Button(action: {
                            quranVM.isShowIndex = true
                        }){
                            Text(sura.name)
                                .waseem(35, weight: .regular)
                                .padding(.vertical, -10)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .lineLimit(1)
                                .minimumScaleFactor(0.1)
                                .contentTransition(.interpolate)
                        }
                        .tint(Color.primary)
                        .contextMenu(menuItems: {
                            if sura.isFavorite {
                                UnstarButton(action: {
                                    withAnimation{
                                        sura.isFavorite = false
                                    }
                                })
                            } else {
                                StarButton{
                                    withAnimation{
                                        sura.isFavorite = true
                                    }
                                }
                            }
                        })
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
                    .padding(.horizontal, 7)
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
                .onAppear{
                    scrollTo = scrollTo
                }
                .onChange(of: scrollTo){ value in
                    withAnimation{
                        scroll.scrollTo(value, anchor: .top)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now()+1){
                        withAnimation{
                            scrollTo = nil
                        }
                    }
                }
                .onReceive(quranVM.$suraViewScrollTo){ value in
                    scrollTo = value
                }
            }
        }
        .background(Color.primary.opacity(0.08).ignoresSafeArea())
        .background(Color.yellow.opacity( sura.isFavorite ? 0.5 : 0 ).ignoresSafeArea())
        .scaleEffect(x: 0.999)
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
