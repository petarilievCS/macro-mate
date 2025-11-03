//
//  MacroTextField.swift
//  MacroMate
//
//  Created by Petar Iliev on 22.10.25.
//

import SwiftUI

struct MacroTextField: View {
    @Binding var text: String
    
    let titleLabel: String
    let unitLabel: String
    
    var body: some View {
        LabeledContent(titleLabel) {
            HStack {
                Spacer()
                TextField("", text: $text)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                Text(unitLabel)
            }
        }
    }
}
