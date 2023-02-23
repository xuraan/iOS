//
//  QuranItemRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-22.
//

import SwiftUI

struct QuranItemRow: View {
    var item: any QuranItem
    var isDismissible: Bool
    
    init(for item: (any QuranItem), isDismissible: Bool = true) {
        self.item = item
        self.isDismissible = isDismissible
    }
    
    var body: some View {
        if let sura = item as? Sura {
            SuraRow(for: sura, isDismissible: isDismissible)
        } else if let sofha = item as? Sofha {
            SofhaRow(for: sofha, isDismissible: isDismissible)
        } else if let aya = item as? Aya {
            AyaRow(for: aya, isDismissible: isDismissible)
        } else if let hizb = item as? Hizb {
            HizbRow(for: hizb, isDismissible: isDismissible)
        }
    }
}

struct QuranItemRow_Previews: PreviewProvider {
    static var previews: some View {
        QuranItemRow(for: Aya.all[90])
    }
}
