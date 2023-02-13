//
//  AyaViewModel.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI

class AyaViewModel: ObservableObject {
    static var ayaFonts = [
        "me_quran",
        "AmiriQuran-Regular",
        "Al-Majeed-Quranic-Font"
    ]
    @Published var ayaFontName: String {
        didSet{
            UserDefaults.standard.set(ayaFontName, forKey: "ayaFontName")
        }
    }
    @Published var ayaFontSize: Double {
        didSet{
            UserDefaults.standard.set(ayaFontSize, forKey: "ayaFontSize")
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
    @Published var isPhonticEnable: Bool {
        didSet{
            UserDefaults.standard.set(isPhonticEnable, forKey: "isPhonticEnable")
        }
    }
    @Published var isPhoneticBold: Bool {
        didSet{
            UserDefaults.standard.set(isPhoneticBold, forKey: "isPhoneticBold")
        }
    }    
    init(){
        if !UserDefaults.standard.bool(forKey: "AyaViewModelIsBoarded"){
            UserDefaults.standard.set(true, forKey: "isUseSystemColorScheme")
            UserDefaults.standard.set("me_quran", forKey: "ayaFontName")
            UserDefaults.standard.set(30.0, forKey: "ayaFontSize")
            UserDefaults.standard.set(17.0, forKey: "transFontSize")
            UserDefaults.standard.set(false, forKey: "isTransBold")
            UserDefaults.standard.set(true, forKey: "isTransEnable")
            UserDefaults.standard.set(true, forKey: "AyaViewModelIsBoarded")
        }
        ayaFontName = UserDefaults.standard.string(forKey: "ayaFontName") ?? "me_quran"
        ayaFontSize = UserDefaults.standard.double(forKey: "ayaFontSize")
        transFontSize = UserDefaults.standard.double(forKey: "transFontSize")
        isTransEnable = UserDefaults.standard.bool(forKey: "isTransEnable")
        isTransBold = UserDefaults.standard.bool(forKey: "isTransBold")
        isPhonticEnable = UserDefaults.standard.bool(forKey: "isPhonticEnable")
        isPhoneticBold = UserDefaults.standard.bool(forKey: "isPhoneticBold")
    }
}

