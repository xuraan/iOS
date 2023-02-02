//
//  ContentView.swift
//  Container
//
//  Created by Samba Diawara on 2023-02-01.
//

import SwiftUI

extension PresentationDetent {
    static let hide = Self.custom(HideDetent.self)
    static let bar = Self.custom(BarDetent.self)
}



private struct BarDetent: CustomPresentationDetent {
    static func height(in context: Context) -> CGFloat? {
        23
    }
}
private struct HideDetent: CustomPresentationDetent {
    static func height(in context: Context) -> CGFloat? {
        0
    }
}

struct ContentView: View {
    @State private var isOpen = false
    @State private var selectedDetent = PresentationDetent.bar

        var body: some View {
            List{
                Button("View Settings") {
                    isOpen = true
                }
            }
            .sheet(isPresented: .constant(true)) {
                NavigationStack{
                    List{
                        
                    }
                    .navigationTitle("Title")
                    .navigationBarTitleDisplayMode(.inline)
                    
                }
                .presentationDetents( isOpen ? [.hide, .large] : [.bar, .large], selection: $selectedDetent)
                .interactiveDismissDisabled(true)
                .onAppear{
                    guard let windows = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
                        return
                    }

                    if let controller =  windows.windows.first?.rootViewController?
                        .presentedViewController, let sheet = controller.presentationController as? UISheetPresentationController{
                    // MARK: As Usual Set Properties What Ever Your Wish Here With Sheet
                    
                        controller.presentingViewController?.view.tintAdjustmentMode = .normal
                        sheet.largestUndimmedDetentIdentifier = .large
                        sheet.preferredCornerRadius = 10
                    }else{
                        print ("NO CONTROLLER FOUND" )
                    }
                }

            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
