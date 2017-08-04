## CommonCryptoForPodspec
`CommonCrypto`在`podspec`中的使用。其实`CommonCrypto`是一个常用的，其他的这样的C库同样可以采用这种方式使用。

## 需要的配置
在`.podspec`中增加：

```ruby
s.pod_target_xcconfig = { 'SWIFT_INCLUDE_PATHS' => '$(PODS_ROOT)/CommonCrypto/' }
s.prepare_command = <<-EOF
    if [ ! -d ./Pods/CommonCrypto ]; then
        mkdir -p ./Pods/CommonCrypto
        cat <<-EOF > ./Pods/CommonCrypto/module.modulemap
        module CommonCrypto [system] {
            header "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/CommonCrypto/CommonCrypto.h"
            export *
        }
        \EOF
    fi
EOF

```

在需要的`.swift`中

```swift
import CommonCrypto
```

## 需要注意

- 有的机器`/usr/include/CommonCrypto/CommonCrypto.h`是不存在的😂，好坑，于是用这个`"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/CommonCrypto/CommonCrypto.h`目录吧。
- 这个`prepare_command`的执行和`.podspec`有关系。也就是说只有`podspec`在安装的时候这个脚本才会执行，这个不变色这个脚本就不会执行。
