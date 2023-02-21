//
//  Container.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-20.
//

import SwiftUI

struct Container<Content:View, Cover: View, SearchView: View>: View {
    var content: Content
    var cover: Cover
    var searchView: SearchView
    @Binding var isOverlayPresended: Bool
    @Binding var searchText: String
    @FocusState var isFocused: Bool
    @State private var keyboardColor: UIKeyboardAppearance = .default
    init(
        _ isOverlayPresended: Binding<Bool>,
        searchText: Binding<String>,
        @ViewBuilder content: @escaping ()-> Content,
        @ViewBuilder cover: @escaping ()-> Cover,
        @ViewBuilder searchView: @escaping ()-> SearchView
    ) {
        self.content = content()
        self.cover = cover()
        self.searchView = searchView()
        self._isOverlayPresended = isOverlayPresended
        self._searchText = searchText
    }
    var body: some View {
        NavigationStack{
            content
            .toolbar(content: {
                Button{
                    withAnimation{
                        isFocused.toggle()
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            })
            .navigationTitle("Quran")
        }
        .scaleEffect(isSearching || isOverlayPresended ? 1.2 : 1)
        .blur(radius: isSearching || isOverlayPresended ? 20 : 0)
        .overlay{
            GeometryReader{ proxy in
                searchView
                    .scrollContentBackground(.hidden)
                    .overlay(alignment: .top) {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .frame(height: proxy.safeAreaInsets.top)
                            .overlay{
                                LinearGradient(colors: [
                                    Color.primary,
                                    Color.primary.opacity(0)
                                ], startPoint: .top, endPoint: .bottom)
                            }
                            .overlay(alignment: .bottom, content: {
                                Divider()
                            })
                            .offset(y: -proxy.safeAreaInsets.top)
                    }

                    .opacity(isSearching ? 1 : 0)
                    .animation( isSearching ? .easeInOut.delay(0.3) : .none, value: isSearching)
                    .safeAreaInset(edge: .bottom) {
                        VStack{}.frame(height: 45)
                    }
            }
        }
        .overlay{
            cover
                .opacity(isOverlayPresended ? 1 : 0)
                .animation( isOverlayPresended ? .easeInOut.delay(0.3) : .none, value: isOverlayPresended)
        }
        .overlay(alignment: .bottom) {
            HStack{
                RoundedRectangle(cornerRadius: 12)
                    .fill(.background)
                    .overlay{
                        TextField("Search", text: $searchText)
                            .focused($isFocused)
                            .keyboardType(.webSearch)
                            .autocorrectionDisabled()
                            .submitLabel(.done)
                            .padding(.horizontal)
                    }
                Button("Cancel"){
                    isFocused = false
                    searchText = ""
                }
            }
            .frame(height: 45)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5))
            .background(Color.keyboard.ignoresSafeArea())
            .offset(y: isSearching ? 0 : 50)
            .opacity(isSearching ? 1 : 0)
        }
        .animation(.easeInOut, value: isFocused)
    }
    
    var isSearching: Bool {
        isFocused || !searchText.isEmpty
    }
}

func getSubviews(of view: AnyView) -> [AnyView] {
        let mirror = Mirror(reflecting: view)
    return mirror.children.compactMap { (label: String?, value: Any) -> AnyView? in
            guard let view = value as? AnyView else {
                return nil
            }
            return view
        }
    }
