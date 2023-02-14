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
        isPhonticEnable = UserDefaults.standard.bool(forKey: "isPhonticEnable")
        isPhoneticBold = UserDefaults.standard.bool(forKey: "isPhoneticBold")
    }
}

