//
//  CertInfo.swift
//  CertFinder
//
//  Created by Joel Rennich on 11/16/20.
//

import Foundation
import ASN1Decoder

struct CertInfo: Identifiable, Hashable {
    
    static func == (lhs: CertInfo, rhs: CertInfo) -> Bool {
        lhs.certData == rhs.certData
    }
    
    var id = UUID()
    
    var certData: Data
    let isValid: Bool
    let issuerDN: String?
    let serial: Data?
    let subjectDN: String?
    let subjectAlt: String
    let notBefore: Date?
    let notAfter: Date?
    let sigAlg: String?
    
    init?(certData: Data) {
        self.certData = certData
        
        if let parsed = try? X509Certificate.init(data: certData) {
            self.isValid = parsed.checkValidity()
            self.issuerDN = parsed.issuerDistinguishedName
            self.serial = parsed.serialNumber
            self.subjectDN = parsed.subjectDistinguishedName
            self.subjectAlt = parsed.subjectAlternativeNames.joined(separator: ", ")
            self.notBefore = parsed.notBefore
            self.notAfter = parsed.notAfter
            self.sigAlg = parsed.sigAlgName
        } else {
            return nil
        }
    }
}
