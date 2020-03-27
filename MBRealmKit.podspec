Pod::Spec.new do |s|
  s.name          = "MBRealmKit"
  s.version       = "2.0.0"
  s.summary       = "MBRealmKit is a public Pod of MBition GmbH" 
  s.description   = "This module handles the offline storage of the MBSDK-Modules. It caches the required data and returns it. It is possible to observe the cached data and to respond to the changes."
  s.homepage      = "https://mbition.io"
  s.license       = 'MIT'
  s.author        = { "MBition GmbH" => "info_mbition@daimler.com" }
  s.source        = { :git => "https://github.com/Daimler/MBSDK-RealmKit-iOS.git", :tag => String(s.version) }
  s.platform      = :ios, '10.0'
  s.swift_version = ['5.0', '5.1', '5.2']

  s.default_subspec = 'All'

  # internal dependencies
  s.dependency 'MBCommonKit/Logger', '~> 2.0'
  
  # external dependencies
  s.dependency 'RealmSwift', '~> 4.0'

  s.subspec "All" do |sp|
    sp.dependency 'MBRealmKit/Layer', '~> 2.0'
    sp.dependency 'MBRealmKit/UI', '~> 2.0'
  end

  s.subspec "Layer" do |sp|
    sp.source_files = 'MBRealmKit/MBRealmKit/**/*.{swift,xib}'
  end

  s.subspec "UI" do |sp|
    sp.source_files = 'MBRealmKit/MBRealmKitUI/**/*.{swift,xib}'
  end
end
