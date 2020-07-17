project 'XCocoaUtilsPublic.xcodeproj'

# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'

def useLib
    pod 'XCocoaUtilsPublic', :path => './' \
    , :subspecs => [
    'General',
    'http',
    'logging',
    'debug',
    'io',
    'concurrency',
    'benchmark',
    'compress',
    'CCommons'
    ]
end

target 'Demo' do
    #pod 'AFNetworking'
    platform :ios, '9.0'
    useLib
    
    target 'DemoTests' do
      #pod 'AFNetworking'
      useLib
    end
end


target 'DemoMacOSCmd' do
  platform :osx, '10.13'
  pod 'XCocoaUtilsPublic', :path => './' \
  , :subspecs => [
  'General',
  'concurrency',
  'compress',
  'macros', 'io', 'debug', 'logging', 'benchmark', 'http'
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
