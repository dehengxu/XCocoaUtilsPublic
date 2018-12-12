project 'XCocoaUtilsPublic.xcodeproj'

# Uncomment this line to define a global platform for your project
platform :ios, '6.0'

target 'Demo' do
    #pod 'AFNetworking'
	pod 'XCocoaUtilsPublic', :path => './', :subspecs => [
#    'categories',
#    'http',
#    'debug',
#    'macros',
#    'io',
#    'UIKit',
    'concurrency',
#    'benchmark',
    ]
end

 target 'DemoTests' do
     #pod 'AFNetworking'
     pod 'XCocoaUtilsPublic', :path => './', :subspecs => ['categories', 'macros', 'http', 'io', 'debug']
 end

# target 'XCocoaUtilsPublic' do

# end

# target 'XCocoaUtilsPublicFW' do

# end
