//
//  SofhaCard.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-20.
//

import SwiftUI

struct SofhaCard: View {
    let sofha: Sofha
    init(for sofha: Sofha) {
        self.sofha = sofha
    }
    var body: some View {
        AyasCard(ayas: sofha.ayas) {
            Text("Page \(sofha.id)")
                .font(.title3.bold())
        }
    }
}
