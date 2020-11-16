//
//  KeychainUtil.swift
//  CertFinder
//
//  Created by Joel Rennich on 11/16/20.
//

import Foundation

class KeychainUtil: ObservableObject {
    
    @Published var totalCerts = 0
    @Published var certs = [CertInfo]()
    
    func findAllCerts() {
                
        let query: [String: Any] = [
            
            // this will only find items provided by a Persistent Token
            // remove the kSecAttrAccessGroup to find all certs
            kSecAttrAccessGroup as String: kSecAttrAccessGroupToken,
            
            kSecAttrKeyClass as String : kSecAttrKeyClassPrivate,
            kSecClass as String : kSecClassIdentity,
            kSecReturnAttributes as String : kCFBooleanTrue as Any,
            kSecReturnRef as String: kCFBooleanTrue as Any,
            kSecMatchLimit as String: kSecMatchLimitAll,
            kSecReturnPersistentRef as String: kCFBooleanTrue as Any
        ]
        
        var result: AnyObject?
        
        let err = SecItemCopyMatching(query as CFDictionary, &result)
        
        if err == 0 {
            if let items = result as? [[String:Any]] {
                for item in items {
                    if let itemLabel = item["labl"] as? String {
                        print("Found: \(itemLabel)")
                        let secRef = item["v_Ref"] as! SecIdentity
                        var cert: SecCertificate?
                        let _ = SecIdentityCopyCertificate(secRef, &cert)
                        if let certUnwrapped = cert {
                            let certData = SecCertificateCopyData(certUnwrapped)
                            if let newCert = CertInfo(certData: certData as Data) {
                                addCert(certInfo: newCert)
                            }
                        }
                    }
                }
            }
        }
        totalCerts = certs.count
    }
    
    func clearCerts() {
        certs = [CertInfo]()
        totalCerts = 0
    }
    
    private func addCert(certInfo: CertInfo) {
        for cert in certs {
            if certInfo == cert {
                return
            }
        }
        certs.append(certInfo)
    }
}
