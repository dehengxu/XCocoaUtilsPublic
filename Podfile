project 'XCocoaUtilsPublic.xcodeproj'

# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'

install! 'cocoapods', :preserve_pod_file_structure => true

def useLib
    pod 'XCocoaUtilsPublic', :path => './' \
    , :subspecs => [
		'All'
#    'General',
#    'http',
#    'Logging',
#    'debug',
#    'io',
#    'Concurrency',
#    'benchmark',
#    'compress',
#    'CCommon',
#		'macros'
    ]
end

target 'Demo' do
    #pod 'AFNetworking'
    platform :ios, '9.0'
    useLib
    
    target 'DemoTests' do
      #pod 'AFNetworking'
    end
end


target 'DemoMacOSCmd' do
  platform :osx, '10.13'
  pod 'XCocoaUtilsPublic', :path => './' \
  , :subspecs => [
  'General',
  'Concurrency',
  'Compress',
  'Macros', 'IO', 'Debug', 'Logging', 'Benchmark', 'HTTP'
  ]
end

target 'DemoMacOSApp' do
  platform :osx, '10.13'
#  pod 'XCocoaUtilsPublic', :path => './' \
#  , :subspecs => [
#  'debug'
#  ]
end

# target 'XCocoaUtilsPublic' do

# end

# target 'XCocoaUtilsPublicFW' do

# end
