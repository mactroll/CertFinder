//
//  ContentView.swift
//  CertFinder
//
//  Created by Joel Rennich on 11/16/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var keychainUtil = KeychainUtil()
    @State var selection: Set<CertInfo> = []

    var body: some View {
        VStack {
            Spacer()
            Text("Cert Finder")
                .font(.largeTitle)
                .bold()
                .padding()
            Text("Sample app to show the use of persistent tokens.")
                .font(.headline)
            Text("Total Certs found: \(String(keychainUtil.totalCerts))")
                    .font(.largeTitle)
                    .padding()
            Spacer()
            if keychainUtil.totalCerts > 0 {
            List {
                ForEach(keychainUtil.certs) { cert in
                    CertDetailView(certInfo: cert, showDetail: self.selection.contains(cert))
                        .onTapGesture {
                            self.toggleSelection(cert)
                        }
                        .animation(.linear(duration: 0.3))
                }
            }
        }
            Button(action: {
                keychainUtil.findAllCerts()
            }, label: {
                Text("Find Certs")
            })
            .buttonStyle(BlueButton())
            if keychainUtil.totalCerts > 0 {
                Button(action: {
                    keychainUtil.clearCerts()
                }, label: {
                    Text("Clear Certs")
                })
                .buttonStyle(BlueButton())
            }
            Spacer()
        }
    }
    
    private func toggleSelection(_ storedCert: CertInfo) {
        if selection.contains(storedCert) {
            selection.remove(storedCert)
        } else {
            selection.insert(storedCert)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
