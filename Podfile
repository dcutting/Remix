platform :ios, '10.3'

use_frameworks!

plugin 'cocoapods-amimono'

target :Remix do
  pod 'Core/Entity', :path => 'Core'
end

target :RemixLogicTests do
  platform :osx, '10.12'
  pod 'Core/Tests', :path => 'Core'
end

# Need to list all dependencies here so CocoaPods can find them.

pod 'Core', :path => 'Core'

post_install do |installer|
  require 'cocoapods-amimono/patcher'
  Amimono::Patcher.patch!(installer)
end
