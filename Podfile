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
    'compress'
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
  'macros', 'io', 'debug', 'logging', 'benchmark'
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
