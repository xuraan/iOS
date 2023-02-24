//
//  ContentView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI

struct ContentView: View {
    @State var isShow: Bool = false
    @EnvironmentObject var model: Model
    @State var pin: (any QuranItem)?

    var body: some View {
        Container {
            HomeView()
        } cover: {
            QuranView()
        }
        .searchable(text: $model.text)
        .onAppear{
            setInitialPin()
        }
        .environment(\.pin, $pin)
    }
    
    func setInitialPin() {
        if let pinValue = UserDefaults.standard.string(forKey: "pin"), let id = Int(pinValue.dropFirst(5)) {
            if pinValue.starts(with: "pin1#")  {
                pin = QuranProvider.shared.sura(id)
            } else if pinValue.starts(with: "pin2#") {
                pin = QuranProvider.shared.aya(id)
            } else if pinValue.starts(with: "pin3#")  {
                pin = QuranProvider.shared.sofha(id)
            } else if pinValue.starts(with: "pin4#")  {
                pin = QuranProvider.shared.hizb(id)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
            .environmentObject(QuranViewModel())
            .environmentObject(KollectionProvider())
    }
}


protocol AnyQuranItem: QuranItem {
    
}
