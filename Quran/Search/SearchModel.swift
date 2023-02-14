//
//  SearchModel.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

class SearchModel: ObservableObject {
    @Published var tokens = [Token]()

    enum Token: String, Identifiable, CaseIterable {
        case sura, aya, sofha
        var id: Self{self}
    }
}

extension SearchModel {
    func search(text: String, in suras: FetchedResults<Sura>) async -> [Sura] {
        if !text.isEmpty{
            if text.isArabic{
                return suras.filter{ $0.name.contains(text)}
            } else if text.isNumeric{
                return suras.filter{ "\($0.id)" == text }
            } else if text.isArabicNumeral{
                return suras.filter{ "\($0.id)".toArabicNumeral == "\(text)" }
            } else {
                return suras.filter{ $0.phonetic.lowercased().contains(text) || $0.translation.lowercased().contains(text) }
            }
        } else {
            return []
        }
    }
    func search(text: String, in suras: [Sura]) async -> [Sura] {
        if !text.isEmpty{
            if text.isArabic{
                return suras.filter{ $0.name.contains(text)}
            } else if text.isNumeric{
                return suras.filter{ "\($0.id)" == text }
            } else if text.isArabicNumeral{
                return suras.filter{ "\($0.id)".toArabicNumeral == "\(text)" }
            } else {
                return suras.filter{ $0.phonetic.lowercased().contains(text) || $0.translation.lowercased().contains(text) }
            }
        } else {
            return []
        }
    }
    func search(text: String, in sofhas: FetchedResults<Sofha>) async -> [Sofha] {
        if !text.isEmpty{
            if text.isNumeric{
                return sofhas.filter{ "\($0.id)" == text }
            } else if text.isArabicNumeral{
                return sofhas.filter{ "\($0.id)".toArabicNumeral == "\(text)" }
            } else {
                return []
            }
        } else {
            return []
        }
    }
    func search(text: String, in sofhas: [Sofha]) async -> [Sofha] {
        if !text.isEmpty{
            if text.isNumeric{
                return sofhas.filter{ "\($0.id)" == text }
            } else if text.isArabicNumeral{
                return sofhas.filter{ "\($0.id)".toArabicNumeral == "\(text)" }
            } else {
                return []
            }
        } else {
            return []
        }
    }
    func search(text: String, in ayas: FetchedResults<Aya>) async -> [Aya] {
        if !text.isEmpty{
            if text.isArabic{
                return ayas.filter{ $0.plain.contains(text) }
            } else if text.isNumeric{
                return ayas.filter{ "\($0.id)" == text }
            } else if text.isArabicNumeral{
                return ayas.filter{ "\($0.id)".toArabicNumeral == "\(text)" }
            } else {
                return ayas.filter{ $0.translation.lowercased().contains(text) }
            }
        } else {
            return []
        }
    }
    func search(text: String, in ayas: [Aya]) async -> [Aya] {
        if !text.isEmpty{
            if text.isArabic{
                return ayas.filter{ $0.plain.contains(text) }
            } else if text.isNumeric{
                return ayas.filter{ "\($0.id)" == text }
            } else if text.isArabicNumeral{
                return ayas.filter{ "\($0.id)".toArabicNumeral == "\(text)" }
            } else {
                return ayas.filter{ $0.translation.lowercased().contains(text) }
            }
        } else {
            return []
        }
    }
}
