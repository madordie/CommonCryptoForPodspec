## CommonCryptoForPodspec
CommonCrypto在podspec中的使用

在`.podspec`中增加：

```ruby
s.pod_target_xcconfig = { 'SWIFT_INCLUDE_PATHS' => '$(PODS_ROOT)/CommonCrypto/' }
s.prepare_command     = <<-EOF
    mkdir Pods/CommonCrypto
    cat <<-EOF > Pods/CommonCrypto/module.modulemap
        module CommonCrypto [system] {
            header "/usr/include/CommonCrypto/CommonCrypto.h"
            export *
        }
    \EOF
EOF
```

在需要的`.swift`中

```swift
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
```
