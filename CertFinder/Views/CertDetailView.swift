//
//  CertDetailView.swift
//  CertFinder
//
//  Created by Joel Rennich on 11/16/20.
//

import SwiftUI

struct CertDetailView: View {
    
    var certInfo: CertInfo
    var showDetail: Bool
    
    let stringDF = DateFormatter()

    var body: some View {
                
        HStack(alignment: .center, spacing: 10, content: {
            Text(certInfo.subjectDN ?? "NONE")
                .padding(.horizontal)
        })
        .contentShape(Rectangle())
        if showDetail {
            VStack(alignment: .leading) {
                Text("Valid: \(certInfo.isValid.description)")
                    .font(.footnote)
                    .padding([.leading, .trailing])
                    .padding(.bottom, 5)
                Text("Subject Alt Names: \(certInfo.subjectAlt)")
                    .font(.footnote)
                    .padding([.leading, .trailing])
                    .padding(.bottom, 5)
                Text("Issuer DN: \(certInfo.issuerDN ?? "Unknown")")
                    .font(.footnote)
                    .padding([.leading, .trailing])
                    .padding(.bottom, 5)
                Text("Serial: \(certInfo.serial?.hexEncodedString() ?? "None")")
                    .font(.footnote)
                    .padding([.leading, .trailing])
                    .padding(.bottom, 5)
                Text("Not Before: \(certInfo.notBefore?.description(with: Locale.current) ?? "None")")
                    .font(.footnote)
                    .padding([.leading, .trailing])
                    .padding(.bottom, 5)
                Text("Not After: \(certInfo.notAfter?.description(with: Locale.current) ?? "None")")
                    .font(.footnote)
                    .padding([.leading, .trailing])
                    .padding(.bottom, 5)
                Text("Signature Algorithim: \(certInfo.sigAlg ?? "None")")
                    .font(.footnote)
                    .padding([.leading, .trailing])
                    .padding(.bottom, 5)
                Text("Public Key: \(certInfo.certData.hexEncodedString())")
                    .font(.footnote)
                    .padding([.leading, .trailing])
            }
        }
    }
    
    private func formatDate(date: Date) -> String {
        stringDF.dateStyle = .long
        stringDF.timeStyle = .medium
        stringDF.locale = Locale.current
        return stringDF.string(from: date)
    }
}
