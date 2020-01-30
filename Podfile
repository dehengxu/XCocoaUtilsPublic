project 'XCocoaUtilsPublic.xcodeproj'

# Uncomment this line to define a global platform for your project
platform :ios, '8.0'

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
    useLib
end

 target 'DemoTests' do
     #pod 'AFNetworking'
     useLib
 end

# target 'XCocoaUtilsPublic' do

# end

# target 'XCocoaUtilsPublicFW' do

# end
