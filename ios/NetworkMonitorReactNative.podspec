Pod::Spec.new do |s|
  s.name         = "NetworkMonitorReactNative"
  s.version      = "0.1.0"
  s.summary      = "React Native bridge for NetworkMonitorKit"
  s.description  = "Low-friction React Native iOS bridge for NetworkMonitorKit."
  s.homepage     = "https://github.com/ryanneilstroud/network-monitor-react-native"
  s.license      = { :type => "MIT" }
  s.author       = { "ryanneilstroud" => "ryanneilstroud@users.noreply.github.com" }
  s.platforms    = { :ios => "15.0" }
  s.source       = { :git => "https://github.com/ryanneilstroud/network-monitor-react-native.git", :tag => s.version.to_s }

  s.source_files = "ios/**/*.{h,m,mm,swift}"
  s.requires_arc = true

  # Place the prebuilt framework in ios/Frameworks/NetworkMonitorKit.xcframework
  # or replace with an artifact download workflow before release.
  s.vendored_frameworks = "ios/Frameworks/NetworkMonitorKit.xcframework"

  s.dependency "React-Core"
end
