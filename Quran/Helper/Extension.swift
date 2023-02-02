//
//  Extension.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI



extension NSOrderedSet {
    var toAyas: [Aya]{
        return self.array as? [Aya] ?? []
    }
    
    var toSuras: [Sura]{
        return self.array as? [Sura] ?? []
    }
        
    
    var toSofhas: [Sofha]{
        return self.array as? [Sofha] ?? []
    }
}

extension Optional where Wrapped == NSOrderedSet {
    var toAyas: [Aya]{
        return self?.array as? [Aya] ?? []
    }
    
    var toSuras: [Sura]{
        return self?.array as? [Sura] ?? []
    }
        
    var toPages: [Sofha]{
        return self?.array as? [Sofha] ?? []
    }
}


extension String {
    var isNumber: Bool {
            return self.range(
                of: "^[0-9]*$", // 1
                options: .regularExpression) != nil
        }
    var isArabicNumber: Bool {
        return self.range(
            of: "^[٠-٩]*$",
            options: .regularExpression) != nil
    }
    var isLatin: Bool {
        return self.range(
            of: "^[a-zA-Z \"\'èéêëēėęàáâäæãåāôöòóœøōõçć,č:.-]*$", // 1
            options: .regularExpression) != nil
    }
    var isArabic: Bool {
            return self.range(
                of: "^[.:\" ء-ي]+$", // 1
                options: .regularExpression) != nil
        }
    var toArabicNumber: String {
        var str =  self.replacingOccurrences(of: "1", with: "١")
        str = str.replacingOccurrences(of: "2", with: "٢")
        str = str.replacingOccurrences(of: "3", with: "٣")
        str = str.replacingOccurrences(of: "4", with: "٤")
        str = str.replacingOccurrences(of: "5", with: "٥")
        str = str.replacingOccurrences(of: "6", with: "٦")
        str = str.replacingOccurrences(of: "7", with: "٧")
        str = str.replacingOccurrences(of: "8", with: "٨")
        str = str.replacingOccurrences(of: "9", with: "٩")
        str = str.replacingOccurrences(of: "0", with: "٠")
        
        return str
    }
    
    func format(stringList: [String] = []) -> AttributedString {
        var ayaFormat = AttributedString(self)
        let ayaFormat1 = AttributedString(self.lowercased())
        for str in stringList {
            if let range = ayaFormat1.range(of: str.lowercased()) {
                ayaFormat[range].foregroundColor = .red.opacity(0.8)
            }
        }
        return ayaFormat
    }
    func format(form string: String, stringList: [String] = []) -> AttributedString {
        var ayaFormat = AttributedString(self)
        let ayaFormat1 = AttributedString(string.lowercased())
        for str in stringList {
            if let range = ayaFormat1.range(of: str.lowercased()) {
                ayaFormat[range].foregroundColor = .red
            }
        }
        return ayaFormat
    }
}

extension String? {
    var notNull: String {self ?? ""}
}

extension View{
    @ViewBuilder
    func mequran(_ size: CGFloat)->some View{
        self.font(.custom("me_quran", size: size))
    }
    @ViewBuilder
    func amiri(_ size: CGFloat)->some View{
        self.font(.custom("AmiriQuran-Regular", size: size))
    }
    @ViewBuilder
    func waseem(_ size: CGFloat, weight: Font.Weight = .regular)->some View{
        self.font(.custom("Waseem", size: size))
            .fontWeight(weight)
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
    
    var contentBG: some View {
        self
        .scrollContentBackground(.hidden)
        .background(Color("bg"))
    }
    
}
