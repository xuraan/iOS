//
//  QuranViewModel.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

class QuranViewModel: ObservableObject {

    @Published var selection: Int{
        didSet{
            UserDefaults.standard.set(selection, forKey: Self.selectionKey)
        }
    }
    
    @Published var tab: Tab = .sofha {
        didSet {
            UserDefaults.standard.set(tab.rawValue, forKey: Self.tabKey)
        }
        willSet {
            switch newValue {
            case .sura:
                if currentAya?.sofhaID != selection {
                    currentAya = QuranProvider.shared.ayasBySofha[selection]?.first
                }
                openButtonAction = openActionModeSura

            case .sofha:
                if currentAya?.suraID != selection {
                    currentAya = QuranProvider.shared.ayasBySura[selection]?.first
                }
                openButtonAction = openActionModeSofha
            }
        }
    }
    
    var currentAya: Aya?
    @Published var suraViewScrollTo: Int = 0
    var openButtonAction: (Aya)->Void = {_ in}

    
    enum Tab: String, CaseIterable, Identifiable, Hashable {
        case sura, sofha
        var id: Self{self}
    }
    
    //MARK: - AyaView
    @Published var arabicFont: CustomFont {
        didSet{
            UserDefaults.standard.set(arabicFont.rawValue, forKey: "arabicFont")
        }
    }
    @Published var arabicFontSize: Double {
        didSet{
            UserDefaults.standard.set(arabicFontSize, forKey: "arabicFontSize")
        }
    }
    @Published var transFontSize: Double {
        didSet{
            UserDefaults.standard.set(transFontSize, forKey: "transFontSize")
        }
    }
    @Published var isTransEnable: Bool {
        didSet{
            UserDefaults.standard.set(isTransEnable, forKey: "isTransEnable")
        }
    }
    @Published var isTransBold: Bool {
        didSet{
            UserDefaults.standard.set(isTransBold, forKey: "isTransBold")
        }
    }
    
    init(){
        let tab = Tab.allCases.first(where: { $0.rawValue == UserDefaults.standard.string(forKey: Self.tabKey) }) ?? .sura
        self.tab = tab
        self.selection = UserDefaults.standard.integer(forKey: Self.selectionKey)
        
        //MARK: - Init AyaViewProprieties
        if !UserDefaults.standard.bool(forKey: "AyaViewModelIsBoarded"){
            UserDefaults.standard.set(true, forKey: "isUseSystemColorScheme")
            UserDefaults.standard.set("me_quran", forKey: "arabicFont")
            UserDefaults.standard.set(30.0, forKey: "arabicFontSize")
            UserDefaults.standard.set(17.0, forKey: "transFontSize")
            UserDefaults.standard.set(false, forKey: "isTransBold")
            UserDefaults.standard.set(true, forKey: "isTransEnable")
            UserDefaults.standard.set(true, forKey: "AyaViewModelIsBoarded")
        }
        arabicFont = CustomFont.availableForAyaArabicText.first{ $0.rawValue == UserDefaults.standard.string(forKey: "arabicFont")} ?? .mequran
        arabicFontSize = UserDefaults.standard.double(forKey: "arabicFontSize")
        transFontSize = UserDefaults.standard.double(forKey: "transFontSize")
        isTransEnable = UserDefaults.standard.bool(forKey: "isTransEnable")
        isTransBold = UserDefaults.standard.bool(forKey: "isTransBold")
               
        
        openButtonAction = tab == .sura ? openActionModeSura : openActionModeSofha
    }
}

extension QuranViewModel {
    static private let tabKey = "7A59038C-E436-4D6C-A5A1-BD4D1A0E682B"
    static private let selectionKey = "A6710D5F-B265-49D8-BA0D-9D585EF075E6"
}

extension QuranViewModel {
    func switchTab() {
        switch tab {
        case .sura:
            tab = .sofha
            if let aya = currentAya {
                selection = aya.sofhaID
            }
        case .sofha:
            tab = .sura
            if let aya = currentAya {
                selection = aya.suraID
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                    self.suraViewScrollTo = aya.id
                }
            }
        }
    }
    
    func openActionModeSura(_ aya: Aya)->Void{
        withAnimation{
            selection = Int(aya.suraID)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                self.suraViewScrollTo = aya.id
            }
        }
    }
    func openActionModeSofha(_ aya: Aya)->Void{
        withAnimation{
            selection = Int(aya.sofhaID)
        }
    }
}



