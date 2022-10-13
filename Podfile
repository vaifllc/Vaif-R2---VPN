inhibit_all_warnings!
use_frameworks!

platform :ios, '15.0'

target 'Vaif R2 - VPN' do
  # Pods for Vaif R2 - VPN V1
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
end


target :'Vaif R2 - VPN Tunnel' do
  pod 'PromiseKit'
  pod 'KeychainAccess'
  pod 'SwiftyStoreKit'
  pod 'ReachabilitySwift'
end

target :'Vaif R2 - VPN Widget' do
  pod 'PromiseKit'
  pod 'SwiftyStoreKit'
  pod 'KeychainAccess'
  pod 'CocoaLumberjack/Swift'
  pod 'ReachabilitySwift'
end

target :'Vaif R2 - VPN Firewall Widget' do
  pod 'PromiseKit'
  pod 'SwiftyStoreKit'
  pod 'KeychainAccess'
  pod 'CocoaLumberjack/Swift'
  pod 'ReachabilitySwift'
end

target :'Vaif R2 - VPNTests' do
  # see https://github.com/pointfreeco/swift-snapshot-testing/pull/308
  #pod 'SnapshotTesting', :git => 'https://github.com/pointfreeco/swift-snapshot-testing.git', :commit => '8e9f685'
  pod 'SnapshotTesting'
end

post_install do |installer|

  # Create plist with info about used frameworks
  plugin 'cocoapods-acknowledgements'
  require 'fileutils'
  FileUtils.cp_r('Pods/Target Support Files/Pods-Vaif R2 - VPN/Pods-Vaif R2 - VPN-acknowledgements.markdown', 'ACKNOWLEDGEMENTS.md')

  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      
      # Reset deployment targets to use the one we have on the main project
      config.build_settings.delete 'MACOSX_DEPLOYMENT_TARGET'
      
    end
  end
end
