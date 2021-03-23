#
#  Be sure to run `pod spec lint XCocoaUtilsPublic.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

source_extensions = "{h,m,mm,c,hpp,cpp,cxx,swift,md}"
included_files = "*.#{source_extensions}"

Pod::Spec.new do |s|
  s.name         = "XCocoaUtilsPublic"
  s.version      = "0.4.6"
  s.summary      = "Utils for iOS development"
  s.description  = <<-DESC
                   XCocoaUtilsPublic is a utilities set for iOS development.

                   * It's a convenient tools set.
                   * I will add osx support in future.
                   
                   DESC

  s.homepage     = "https://gitee.com/dehengxu/XCocoaUtilsPublic"
  # s.module_name = "XCocoaUtilsPublic"
  # s.module_map = "./src/XCocoaUtilsPublic/XCocoaUtilsPublic.modulemap"
  
  s.license      = "MIT"
  s.author             = { "DehengXu" => "dehengxu@outlook.com" }
  # s.authors            = { "DehengXu" => "dehengxu@outlook.com" }
  #s.social_media_url   = "http://twitter.com/dehengxu"
#  s.platform     = :ios
  s.platform     = :ios, "8.0"
  s.platform     = :osx, "10.13"
  
  #  When using multiple platforms
   s.ios.deployment_target = "8.0"
   s.osx.deployment_target = "10.13"
  s.source       = { :git => "https://gitee.com/dehengxu/XCocoaUtilsPublic.git", :tag => s.version }
  s.source_files  = "src/XCocoaUtilsPublic/**/*.{h,m}"
  # Remove file from link list.
  s.exclude_files = "src/**/RegexKitLite.{h,m}"
  s.public_header_files = "src/XCocoaUtilsPublic/**/*.h"
  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

#   s.preserve_paths = "./src/XCocoaUtilsPublic/XCocoaUtilsPublic.modulemap"
  # s.framework  = "SomeFramework"
   s.ios.frameworks = "UIKit"#, "AnotherFramework"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.subspec 'export' do |sp|
    sp.source_files = "src/XCocoaUtilsPublic/XCocoaUtilsPublic.h"
  end
  
  s.subspec 'All' do |sp|
		sp.dependency 'XCocoaUtilsPublic/ObjC'
    sp.dependency 'XCocoaUtilsPublic/Swift'
  end

  s.subspec 'ObjC' do |sp|

		sp.dependency 'XCocoaUtilsPublic/HTTP'
		sp.dependency 'XCocoaUtilsPublic/UIKit'
		sp.dependency 'XCocoaUtilsPublic/Debug'
		sp.dependency 'XCocoaUtilsPublic/IO'
		sp.dependency 'XCocoaUtilsPublic/Benchmark'
		sp.dependency 'XCocoaUtilsPublic/Concurrency'
		sp.dependency 'XCocoaUtilsPublic/Runtime'
		sp.dependency 'XCocoaUtilsPublic/Logging'
		sp.dependency 'XCocoaUtilsPublic/Compress'
    sp.dependency 'XCocoaUtilsPublic/CCommon'
    sp.dependency 'XCocoaUtilsPublic/Foundation'
	end

	s.subspec 'Swift' do |sp|
		sp.source_files = "src/XCocoaUtilsPublic/Swift/**/#{included_files}"
    # sp.exclude_files = "src/XCocoaUtilsPublic/Swift/**/*.md"
		# sp.preserve_paths = "src/XCocoaUtilsPublic/Swift/docs/#{included_files}"
	end

  # General module | 常用模块组
  s.subspec 'General' do |sp|
    sp.dependency 'XCocoaUtilsPublic/HTTP'
    sp.dependency 'XCocoaUtilsPublic/Logging'
    sp.dependency 'XCocoaUtilsPublic/Compress'
    sp.dependency 'XCocoaUtilsPublic/Debug'
    sp.dependency 'XCocoaUtilsPublic/Benchmark'
    sp.dependency 'XCocoaUtilsPublic/Logging'
    sp.dependency 'XCocoaUtilsPublic/Foundation'
    sp.dependency 'XCocoaUtilsPublic/CCommon'
  end
  
  # Basically module | 基础模块
	s.subspec 'CCommon' do |sp|
    #sp.platform = :mac, "10.13"
		sp.source_files = "src/XCocoaUtilsPublic/CCommon/**/*.#{source_extensions}"
    sp.dependency 'XCocoaUtilsPublic/Macros'
    sp.dependency 'XCocoaUtilsPublic/export'
	end
  
  s.subspec 'Macros' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/Macros/**/*.#{source_extensions}"
      #sp.preserve_paths = "src/XCocoaUtilsPublic/Macros"
      sp.dependency 'XCocoaUtilsPublic/export'
  end

  s.subspec 'Categories' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/Categories/**/*.#{source_extensions}"
      sp.dependency "XCocoaUtilsPublic/Macros"
      #sp.preserve_paths = "src/XCocoaUtilsPublic/Categories"
      sp.dependency 'XCocoaUtilsPublic/export'
  end

  # Application module | 应用模块
  s.subspec 'HTTP' do |sp|
    sp.source_files = "src/XCocoaUtilsPublic/HTTP/**/*.#{source_extensions}"
    sp.dependency "XCocoaUtilsPublic/Categories"
    #sp.preserve_paths = "src/XCocoaUtilsPublic/HTTP"
    sp.dependency 'XCocoaUtilsPublic/export'
  end
  
  s.subspec 'UIKit' do |sp|
    sp.platform = :ios, "9.0"
    sp.source_files = "src/XCocoaUtilsPublic/UIKit/**/*.#{source_extensions}"
    sp.dependency "XCocoaUtilsPublic/Categories"
    sp.dependency 'XCocoaUtilsPublic/export'
    #sp.preserve_paths = "src/XCocoaUtilsPublic/UIKit"
  end
  
  s.subspec 'Foundation' do |sp|
    sp.source_files = "src/XCocoaUtilsPublic/Foundation/**/*.#{source_extensions}"
    sp.dependency "XCocoaUtilsPublic/Categories"
    sp.dependency 'XCocoaUtilsPublic/export'
  end
  
  s.subspec 'Debug' do |sp|
    sp.source_files = "src/XCocoaUtilsPublic/Debug/**/*.#{source_extensions}"
    #sp.preserve_paths = "src/XCocoaUtilsPublic/Debug"
    sp.dependency 'XCocoaUtilsPublic/export'
  end
  
  # Independent module | 独立模块
  
  s.subspec 'IO' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/IO/**/*.#{source_extensions}"
      sp.preserve_paths = "src/XCocoaUtilsPublic/IO"
      #sp.dependency "XCocoaUtilsPublic/Debug"
      sp.dependency 'XCocoaUtilsPublic/export'
  end
  
  s.subspec 'Benchmark' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/Benchmark/**/#{included_files}"
      sp.dependency 'XCocoaUtilsPublic/export'
  end
  
  s.subspec 'Concurrency' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/Concurrency/**/*.#{source_extensions}"
      #sp.preserve_paths = "src/XCocoaUtilsPublic/Concurrency"
      sp.dependency 'XCocoaUtilsPublic/export'
  end

  s.subspec 'Runtime' do |sp|
      sp.source_files = "src/XCocoaUtilsPublic/Runtime/**/*.#{source_extensions}"
      #sp.preserve_paths = "src/XCocoaUtilsPublic/Runtime"
      sp.dependency 'XCocoaUtilsPublic/export'
  end

  s.subspec 'Logging' do |sp|
	  sp.source_files = "src/XCocoaUtilsPublic/Logging/**/*.#{source_extensions}"
    #sp.preserve_paths = "src/XCocoaUtilsPublic/Logging"
    sp.dependency 'XCocoaUtilsPublic/export'
  end

  s.subspec 'Compress' do |sp|
    sp.source_files = "src/XCocoaUtilsPublic/Compress/**/*.#{source_extensions}"
    sp.libraries = "z"
    #sp.preserve_paths = "src/XCocoaUtilsPublic/Compress"
    sp.dependency 'XCocoaUtilsPublic/export'
  end

  # s.default_subspec = "General"
  s.requires_arc = true
  s.swift_version = "5.0"
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency 'RegexKitLite', '~> 4.0'

end
