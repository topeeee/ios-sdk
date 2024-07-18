Pod::Spec.new do |spec|

  spec.name         = "ComplianceSdk"
  spec.version      = "1.0.0"
  spec.summary      = "A short description of ComplianceSdk for making sure user pass compliance"
  spec.description  = "This is a compliance sdk that in use in phones to make use all the users using it pass all the compliance and kyc"

  spec.homepage     = "https://github.com/topeeee/ios-sdk"

  spec.license      = "MIT"


  spec.author             = { "tope" => "tajibuwa@gmail.com" }

  spec.platform     = :ios, "16.0"

  spec.source       = { :git => "https://github.com/topeeee/ios-sdk.git", :tag => spec.version.to_s }


  spec.source_files  = "Sources/**/*.{swift}"

  spec.swift_version = "5.0"

#   spec.resource  = "icon.png"
#   spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
