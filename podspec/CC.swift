//
//  CC.swift
//  Pods
//
//  Created by 孙继刚 on 2017/8/4.
//
//

import Foundation
import CommonCrypto

public func SHA(key: String, text: String) -> String {
    if let cData = text.data(using: .utf8), let cKey = key.data(using: .utf8) {
        var cHMAC = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        cKey.withUnsafeBytes({ (ptr:UnsafePointer<UInt8>) -> Void in
            cData.withUnsafeBytes({
                CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), ptr, cKey.count, $0, cData.count, &cHMAC)
            })
        })
        let hexBytes = cHMAC.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
    return ""
}
