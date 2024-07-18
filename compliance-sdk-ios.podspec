# Pod::Spec.new do |spec|
#
#   spec.name         = "compliance-sdk-ios"
#   spec.version      = " 1.0.1"
#   spec.summary = "A compliance SDK ensuring users pass all KYC and compliance checks."
#   spec.description  = "This is a compliance sdk that in use in phones to make use all the users using it pass all the compliance and kyc"
#
#   spec.homepage     = "https://github.com/topeeee/ios-sdk"
#
#   spec.license      = { :type => "MIT", :file => 'LICENSE.txt' }
#
#
#   spec.author             = { "tope" => "tajibuwa@gmail.com" }
#
#   spec.platform     = :ios, "16.0"
#
#   spec.source       = { :git => "https://github.com/topeeee/ios-sdk.git", :tag => spec.version.to_s }
#
#
#   spec.source_files  = "Sources/**/*.{swift}"
#
#   spec.swift_version = "5.0"
#
#   spec.resource_bundles = {
#     'ComplianceSDK' => ['Sources/**/*.xcassets', 'Sources/**/*.ttf', 'Sources/**/*.otf']
#   }
#
# #   spec.resource  = "icon.png"
# #   spec.resources = "Resources/*.png"
#
#   # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"
#
#
#   # spec.framework  = "SomeFramework"
#   # spec.frameworks = "SomeFramework", "AnotherFramework"
#
#   # spec.library   = "iconv"
#   # spec.libraries = "iconv", "xml2"
#
#
#   # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#   #
#   #  If your library depends on compiler flags you can set them in the xcconfig hash
#   #  where they will only apply to your library. If you depend on other Podspecs
#   #  you can include multiple dependencies to ensure it works.
#
#   # spec.requires_arc = true
#
#   # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
#   # spec.dependency "JSONKit", "~> 1.4"
#
# end

Pod::Spec.new do |spec|
  spec.name         = "compliance-sdk-ios"
  spec.version      = "1.0.4"
  spec.summary      = "A compliance SDK ensuring users pass all KYC and compliance checks."
  spec.description  = "This is a compliance SDK that is used in phones to ensure all users pass all the compliance and KYC checks."

  spec.homepage     = "https://github.com/topeeee/ios-sdk"
  spec.license      = { :type => "MIT", :file => 'LICENSE' }
  spec.author       = { "tope" => "tajibuwa@gmail.com" }
  spec.platform     = :ios, "16.0"
  spec.source       = { :git => "https://github.com/topeeee/ios-sdk.git", :tag => spec.version.to_s }
  spec.source_files = "Sources/**/*.{swift}"
  spec.swift_version = "5.0"

  spec.resource_bundles = {
    'ComplianceSDK' => [
      'Sources/compliance-sdk-ios/Fonts/Millik.otf',
      'Sources/compliance-sdk-ios/Fonts/Moderat-Bold.ttf',
      'Sources/compliance-sdk-ios/Fonts/Moderat-Light.ttf',
      'Sources/compliance-sdk-ios/Fonts/Moderat-Medium.ttf',
      'Sources/compliance-sdk-ios/Fonts/Moderat-Regular.ttf',
      'Sources/**/*.xcassets'
    ]
  }
end

