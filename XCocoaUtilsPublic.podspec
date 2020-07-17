#
#  Be sure to run `pod spec lint XCocoaUtilsPublic.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "XCocoaUtilsPublic"

  s.version      = "0.4.5"
  s.summary      = "Utils for iOS development"

  s.description  = <<-DESC
                   XCocoaUtilsPublic is a utilities set for iOS development.

                   * It's a convenient tools set.
                   * I will add osx support in future.
                   
                   DESC

  s.homepage     = "https://github.com/xudeheng/XCocoaUtilsPublic"
  # s.homepage     = "git@bitbucket.org:xudeheng/XCocoaUtilsPublic"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.module_name = "XCocoaUtilsPublic"
  
  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "DehengXu" => "dehengxu@outlook.com" }
  # Or just: s.author    = "DehengXu"
  # s.authors            = { "DehengXu" => "dehengxu@outlook.com" }
  s.social_media_url   = "http://twitter.com/dehengxu"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

#  s.platform     = :ios
#  s.platform     = :ios, "8.0"

  #  When using multiple platforms
   s.ios.deployment_target = "8.0"
   s.osx.deployment_target = "10.13"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/xudeheng/XCocoaUtilsPublic.git", :tag => s.version }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any h, m, mm, c & cpp files. For header
  #  files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "src/XCocoaUtilsPublic/*.{h,m}"

  # Remove file from link list.
  s.exclude_files = "src/**/RegexKitLite.{h,m}"

  s.public_header_files = "src/XCocoaUtilsPublic/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # General module | 常用模块组
  s.subspec 'General' do |sp|
    sp.dependency 'XCocoaUtilsPublic/categories'
    sp.dependency 'XCocoaUtilsPublic/http'
    sp.dependency 'XCocoaUtilsPublic/logging'
    sp.dependency 'XCocoaUtilsPublic/compress'
    sp.dependency 'XCocoaUtilsPublic/CCommons'
  end
  
  s.subspec 'CCommons' do |sp|
    sp.source_files = "src/XCocoaUtilsPublic/CCommons/*.{h,m,c,mm,cpp,cxx,hpp}"
  end
  
  # Basically module | 基础模块
  s.subspec 'macros' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/macros/*.{h}"
      sp.preserve_paths = "src/XCocoaUtilsPublic/macros"
  end

  s.subspec 'categories' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/categories/*.{h,m}"
      sp.dependency "XCocoaUtilsPublic/macros"
      sp.preserve_paths = "src/XCocoaUtilsPublic/categories"
  end

  # Application module | 应用模块
  s.subspec 'http' do |sp|
    sp.source_files = "src/XCocoaUtilsPublic/http/*.{h,m}"
    sp.dependency "XCocoaUtilsPublic/categories"
    sp.preserve_paths = "src/XCocoaUtilsPublic/http"
  end
  
  s.subspec 'UIKit' do |sp|
    sp.platform = :ios, "8.0"
    sp.source_files = "src/XCocoaUtilsPublic/UIKit/*.{h,m}"
    sp.dependency "XCocoaUtilsPublic/categories"
    sp.preserve_paths = "src/XCocoaUtilsPublic/UIKit"
  end
  
  s.subspec 'debug' do |sp|
    sp.source_files = "src/XCocoaUtilsPublic/debug/*.{h,m}"
    sp.preserve_paths = "src/XCocoaUtilsPublic/debug"
  end
  
  # Independent module | 独立模块
  
  s.subspec 'io' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/io/*.{h,m}"
      sp.preserve_paths = "src/XCocoaUtilsPublic/io"
      sp.dependency "XCocoaUtilsPublic/debug"
  end
  
  s.subspec 'benchmark' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/benchmark/*.{h,m,c}"
      sp.preserve_paths = "src/XCocoaUtilsPublic/benchmark"
  end
  
  s.subspec 'concurrency' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/concurrency/*.{h,m}"
      sp.preserve_paths = "src/XCocoaUtilsPublic/concurrency"
  end

  s.subspec 'runtime' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/Runtime/*.{h,m}"
      sp.preserve_paths = "src/XCocoaUtilsPublic/Runtime"
  end

  s.subspec 'logging' do |sp|
	  sp.source_files = "src/XCocoaUtilsPublic/Logging/*.{h,m,c,cpp,cxx,cc}"
    sp.preserve_paths = "src/XCocoaUtilsPublic/Logging"
  end

  s.subspec 'compress' do |sp|
    sp.source_files = "src/XCocoaUtilsPublic/compress/*.{h,m,mm,c,cpp,cxx,cc}"
    sp.libraries = "z"
    sp.preserve_paths = "src/XCocoaUtilsPublic/compress"
  end

  s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency 'RegexKitLite', '~> 4.0'

end
