Pod::Spec.new do |s|
  s.name         = "AirMenuKit"
  s.version      = "0.0.1"
  s.summary      = "AirMenuKit is a Objective-C wrapper for AirMenu API"
  s.description  = <<-DESC
                    * Easy to use library, that simplyfies connceting to AirMenu API"
                    * Always in sync with current API release.
                   DESC
  s.homepage     = "http://www.air-menu.com"
  s.license      = 'MIT'
  s.author       = { "robertlis" => "robert.lis2@mail.dcu.ie" }
  s.source       = { :git => "https://github.com/brogrammers/air-menu-kit.git", :tag => s.version.to_s, :commit => "f121c261c9a88763b0a7178c3642d0603d2b10c0"}
  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'
  s.requires_arc = true
  s.source_files = 'Classes'
  s.frameworks = 'Foundation'
end
