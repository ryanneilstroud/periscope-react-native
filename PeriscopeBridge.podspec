Pod::Spec.new do |s|
  s.name         = "PeriscopeBridge"
  s.version      = "0.5.5"
  s.summary      = "React Native bridge for PeriscopeKit"
  s.description  = "Low-friction React Native bridge that depends on PeriscopeKit."
  s.homepage     = "https://github.com/ryanneilstroud/periscope-react-native"
  s.license      = { :type => "MIT" }
  s.author       = { "ryanneilstroud" => "ryanneilstroud@users.noreply.github.com" }
  s.platforms    = { :ios => "15.0" }
  s.source       = { :git => "https://github.com/ryanneilstroud/periscope-react-native.git", :tag => s.version.to_s }

  s.source_files = "ios/PeriscopeBridge.{h,m,mm,swift}"
  s.requires_arc = true
  s.swift_version = "5.10"
  s.pod_target_xcconfig = { "DEFINES_MODULE" => "YES" }

  s.dependency "React-Core"
  s.dependency "PeriscopeKit", "0.5.5"
end
