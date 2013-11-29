#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
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
  s.source       = { :git => "https://github.com/brogrammers/air-menu-kit", :tag => s.version.to_s }
  # s.platform     = :ios, '5.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes'
  s.resources = 'Assets'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  # s.dependency 'JSONKit', '~> 1.4'
end
