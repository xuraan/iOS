//
//  PinButton.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-22.
//

import SwiftUI

struct PinButton<T: QuranItem>: View {
    @Environment(\.isDestructivePinButton) var isDestructive
    @Environment(\.pin) var pin
    var object: T
    
    init(_ object: T) {
        self.object = object
    }
    
    var body: some View {
        Button(role: isDestructive ? .destructive : .cancel , action: action) {
            Label( isPinned ? "Unpin" : "Pin", systemImage: "pin\(isPinned ? ".slash" : "")")
        }
        .tint(.gray)
    }
    var isPinned: Bool { pin.wrappedValue as? T == object }
    func action() {
        withAnimation {
            if isPinned {
                UserDefaults.standard.set("pin5#nil", forKey: "pin")
                pin.wrappedValue = nil
            } else {
                pin.wrappedValue = object as (any QuranItem)?
            }
        }
    }
}


//MARK: - pinnedKey
struct PinKey: EnvironmentKey {
    static var defaultValue: Binding<(any QuranItem)?> = .constant(nil)
}
extension EnvironmentValues {
    var pin: Binding<(any QuranItem)?> {
        get{self[PinKey.self]}
        set{
            self[PinKey.self] = newValue
            if let sura = newValue.wrappedValue as? Sura {
                UserDefaults.standard.set("pin1#\(sura.id)", forKey: "pin")
            } else if let aya = newValue.wrappedValue as? Aya {
                UserDefaults.standard.set("pin2#\(aya.id)", forKey: "pin")
            } else if let sofha = newValue.wrappedValue as? Sofha {
                UserDefaults.standard.set("pin3#\(sofha.id)", forKey: "pin")
            } else if let hizb = newValue.wrappedValue as? Hizb {
                UserDefaults.standard.set("pin4#\(hizb.id)", forKey: "pin")
            }
        }
    }
}

//MARK: - IsDestructiveKey
struct IsDestructivePinButtonKey: EnvironmentKey {
    static var defaultValue: Bool = false
}
extension EnvironmentValues {
    var isDestructivePinButton: Bool {
        get{self[IsDestructivePinButtonKey.self]}
        set{self[IsDestructivePinButtonKey.self] = newValue }
    }
}

struct PinButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            PinButton(Aya.all[90])
            PinButton(Sura.all[89])
        }
        .environment(\.pin, .constant(nil))
    }
}

