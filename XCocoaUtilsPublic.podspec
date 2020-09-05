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

	source_extensions = "{h,m,mm,c,hpp,cpp,cxx,swift}"

  s.name         = "XCocoaUtilsPublic"

  s.version      = "0.4.6"
  s.summary      = "Utils for iOS development"

  s.description  = <<-DESC
                   XCocoaUtilsPublic is a utilities set for iOS development.

                   * It's a convenient tools set.
                   * I will add osx support in future.
                   
                   DESC

  s.homepage     = "https://gitee.com/dehengxu/XCocoaUtilsPublic"
  # s.homepage     = "git@bitbucket.org:xudeheng/XCocoaUtilsPublic"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.module_name = "XCocoaUtilsPublic"
  s.module_map = "./src/XCocoaUtilsPublic/XCocoaUtilsPublic.modulemap"
  
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
  #s.social_media_url   = "http://twitter.com/dehengxu"

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

  s.source       = { :git => "https://gitee.com/dehengxu/XCocoaUtilsPublic.git", :tag => s.version }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any h, m, mm, c & cpp files. For header
  #  files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "src/XCocoaUtilsPublic/**/*.{h,m}"

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

   s.preserve_paths = "./src/XCocoaUtilsPublic/XCocoaUtilsPublic.modulemap"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
   s.ios.frameworks = "UIKit"#, "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.subspec 'All' do |sp|
		sp.dependency 'XCocoaUtilsPublic/ObjC'
    sp.dependency 'XCocoaUtilsPublic/Swift'
  end

	s.subspec 'ObjC' do |sp|
		sp.dependency 'XCococUtilsPublic/Base'

		sp.dependency 'XCocoaUtilsPublic/HTTP'
		sp.dependency 'XCocoaUtilsPublic/UIKit'
		sp.dependency 'XCocoaUtilsPublic/Debug'
		sp.dependency 'XCocoaUtilsPublic/IO'
		sp.dependency 'XCocoaUtilsPublic/Benchmark'
		sp.dependency 'XCocoaUtilsPublic/Concurrency'
		sp.dependency 'XCocoaUtilsPublic/Runtime'
		sp.dependency 'XCocoaUtilsPublic/Logging'
		sp.dependency 'XCocoaUtilsPublic/Compress'
	end

	s.subspec 'Swift' do |sp|
		sp.source_files = "src/XCocoaUtilsPublic/Swift/*.swift"
		#sp.preserve_paths = "src/XCocoaUtilsPublic/Swift"
	end

	s.subspec 'Base' do |sp|
		sp.dependency 'XCocoaUtilsPublic/CCommon'
		sp.dependency 'XCocoaUtilsPublic/Macros'
		sp.dependency 'XCocoaUtilsPublic/Categories'
	end

  # General module | 常用模块组
  s.subspec 'General' do |sp|
		sp.dependency 'XCocoaUtilsPublic/Base'
    sp.dependency 'XCocoaUtilsPublic/HTTP'
    sp.dependency 'XCocoaUtilsPublic/Logging'
    sp.dependency 'XCocoaUtilsPublic/Compress'
    sp.dependency 'XCocoaUtilsPublic/Swift'
  end
  
  # Basically module | 基础模块
	s.subspec 'CCommon' do |sp|
		sp.source_files = "src/XCocoaUtilsPublic/CCommon/*.#{source_extensions}"
	end

  s.subspec 'Macros' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/Macros/*.#{source_extensions}"
      sp.preserve_paths = "src/XCocoaUtilsPublic/Macros"
  end

  s.subspec 'Categories' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/Categories/*.#{source_extensions}"
      sp.dependency "XCocoaUtilsPublic/Macros"
      sp.preserve_paths = "src/XCocoaUtilsPublic/Categories"
  end

  # Application module | 应用模块
  s.subspec 'HTTP' do |sp|
    sp.source_files = "src/XCocoaUtilsPublic/HTTP/*.#{source_extensions}"
    sp.dependency "XCocoaUtilsPublic/Categories"
    sp.preserve_paths = "src/XCocoaUtilsPublic/HTTP"
  end
  
  s.subspec 'UIKit' do |sp|
    sp.platform = :ios, "9.0"
    sp.source_files = "src/XCocoaUtilsPublic/UIKit/*.#{source_extensions}"
    sp.dependency "XCocoaUtilsPublic/Categories"
    sp.preserve_paths = "src/XCocoaUtilsPublic/UIKit"
  end
  
  s.subspec 'Debug' do |sp|
    sp.source_files = "src/XCocoaUtilsPublic/Debug/*.#{source_extensions}"
    sp.preserve_paths = "src/XCocoaUtilsPublic/Debug"
  end
  
  # Independent module | 独立模块
  
  s.subspec 'IO' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/IO/*.#{source_extensions}"
      sp.preserve_paths = "src/XCocoaUtilsPublic/IO"
      sp.dependency "XCocoaUtilsPublic/Debug"
  end
  
  s.subspec 'Benchmark' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/Benchmark/*.#{source_extensions}"
      sp.preserve_paths = "src/XCocoaUtilsPublic/Benchmark"
  end
  
  s.subspec 'Concurrency' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/Concurrency/*.#{source_extensions}"
      sp.preserve_paths = "src/XCocoaUtilsPublic/Concurrency"
  end

  s.subspec 'Runtime' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/Runtime/*.#{source_extensions}"
      sp.preserve_paths = "src/XCocoaUtilsPublic/Runtime"
  end

  s.subspec 'Logging' do |sp|
	  sp.source_files = "src/XCocoaUtilsPublic/Logging/*.#{source_extensions}"
    sp.preserve_paths = "src/XCocoaUtilsPublic/Logging"
  end

  s.subspec 'Compress' do |sp|
    sp.source_files = "src/XCocoaUtilsPublic/Compress/*.#{source_extensions}"
    sp.libraries = "z"
    sp.preserve_paths = "src/XCocoaUtilsPublic/Compress"
  end

  s.default_subspec = "General"
  s.requires_arc = true
  s.swift_version = "5.0"
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency 'RegexKitLite', '~> 4.0'

end
