//
//  ButtonStyle+Blue.swift
//  CertFinder
//
//  Created by Joel Rennich on 11/16/20.
//

import Foundation
import SwiftUI

struct BlueButton: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color(.blue))
            .cornerRadius(40)
            .padding(.horizontal, 20)
    }
}
