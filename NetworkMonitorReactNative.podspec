Pod::Spec.new do |s|
  s.name         = "NetworkMonitorReactNative"
  s.version      = "0.1.0"
  s.summary      = "React Native bridge for NetworkMonitorKit"
  s.description  = "Low-friction React Native iOS bridge that depends on NetworkMonitorKit."
  s.homepage     = "https://github.com/ryanneilstroud/network-monitor-react-native"
  s.license      = { :type => "MIT" }
  s.author       = { "ryanneilstroud" => "ryanneilstroud@users.noreply.github.com" }
  s.platforms    = { :ios => "15.0" }
  s.source       = { :git => "https://github.com/ryanneilstroud/network-monitor-react-native.git", :tag => s.version.to_s }

  s.source_files = "ios/NetworkMonitorReactNative.{h,m,mm,swift}"
  s.requires_arc = true
  s.swift_version = "5.10"
  s.pod_target_xcconfig = { "DEFINES_MODULE" => "YES" }

  s.dependency "React-Core"
  s.dependency "NetworkMonitorKit"
end
