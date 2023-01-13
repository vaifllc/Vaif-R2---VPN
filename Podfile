# Uncomment the next line to define a global platform for your project
inhibit_all_warnings!
use_frameworks!

platform :ios, '15.0'

target 'VaifR2' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
plugin 'cocoapods-acknowledgements', :settings_bundle => true
  pod 'AwesomeSpotlightView'
  pod 'RQShineLabel'
  pod 'NicoProgress'
  pod 'ReachabilitySwift'
  pod 'SwiftMessages'
  pod 'PromiseKit'
  pod 'SwiftyStoreKit'
  pod 'KeychainAccess'
  pod 'CocoaLumberjack/Swift'
  pod 'PopupDialog'
  
  # External Pods
  pod 'lottie-ios'
  pod 'GSMessages'
  pod 'TrustKit'
  pod 'AFNetworking'
  pod 'AwaitKit', :git => 'https://github.com/yannickl/AwaitKit.git', :commit => '4b725f40dd189f40c0962cba792f06a2073bd977'
  pod 'Logging'
  pod 'SecurityKit'
  pod 'Connectivity'
  
  #Pods For Downgrade

  pod 'GBDeviceInfo/Jailbreak', '~> 6.0'
  pod 'PureLayout'
  pod 'SwiftDate'
  pod 'SideMenu'
  pod "Macaw", "0.9.7"
  pod 'Localize-Swift', '~> 3.2'
  pod 'SVProgressHUD'
  pod 'TTTAttributedLabel'
  pod 'SVPullToRefresh'
  pod 'GoogleUtilities'
  pod 'SwiftValidator', :git => 'https://github.com/jpotts18/SwiftValidator.git', :tag => '4.2.0'
  pod 'SwiftValidators'
  pod 'Navajo-Swift'
  pod 'FloatingPanel', '~> 1.7.2'
  pod 'SnapKit', '~> 5.0.1'
  pod 'TunnelKit', '~> 3.5.0'
  pod 'OpenSSL-Apple', :path => '/Users/vaif/openssl-apple'
  


  # Pods for VaifR2

  target 'VaifR2Tests' do
    inherit! :search_paths
    # Pods for testing
  # see https://github.com/pointfreeco/swift-snapshot-testing/pull/308
  #pod 'SnapshotTesting', :git => 'https://github.com/pointfreeco/swift-snapshot-testing.git', :commit => '8e9f685'
  pod 'SnapshotTesting'
  end

end

target 'VaifR2 Blocker' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for VaifR2 Blocker

end

target 'VaifR2 Firewall Widget' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'PromiseKit'
  pod 'SwiftyStoreKit'
  pod 'KeychainAccess'
  pod 'CocoaLumberjack/Swift'
  pod 'ReachabilitySwift'

  # Pods for VaifR2 Firewall Widget

end

target 'VaifR2 FirewallWidget ExtensionExtension' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for VaifR2 FirewallWidget ExtensionExtension

end

target 'VaifR2 Tunnel' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for VaifR2 Tunnel
  pod 'PromiseKit'
  pod 'KeychainAccess'
  pod 'SwiftyStoreKit'
  pod 'ReachabilitySwift'

end

target 'VaifR2 Widget' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for VaifR2 Widget
  pod 'PromiseKit'
  pod 'SwiftyStoreKit'
  pod 'KeychainAccess'
  pod 'CocoaLumberjack/Swift'
  pod 'ReachabilitySwift'

end

target 'wireguard-tunnel-provider' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for wireguard-tunnel-provider
    pod 'KeychainAccess'
    pod 'Logging'

end

post_install do |installer|

  # Create plist with info about used frameworks
  plugin 'cocoapods-acknowledgements'
  require 'fileutils'
  FileUtils.cp_r('Pods/Target Support Files/Pods-VaifR2/Pods-VaifR2-acknowledgements.markdown', 'ACKNOWLEDGEMENTS.md')

  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      
      # Reset deployment targets to use the one we have on the main project
      config.build_settings.delete 'MACOSX_DEPLOYMENT_TARGET'
      
    end
  end
end
