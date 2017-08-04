Pod::Spec.new do |s|
s.name         = 'CC'
s.version      = '0.0.1'
s.license      = { :type => 'MIT' }
s.homepage     = 'https://github.com/madordie/CommonCryptoForPodspec'
s.author       = { 'sunjigang' => 'keith_127@126.com' }
s.summary      = 'CC'

s.platform     =  :ios, '7.0'
s.source       =  { :git => 'https://github.com/madordie/CommonCryptoForPodspec.git' }
s.framework    = 'UIKit'
s.requires_arc = true

s.source_files = 'podspec/*.swift'

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

end
