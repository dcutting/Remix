platform :ios, '10.3'

use_frameworks!

plugin 'cocoapods-amimono'

target :Remix do
  pod 'Entity/Core', :path => 'Entity'
  pod 'Wireframe/UIKit', :path => 'Wireframe'
end

target :RemixLogicTests do
  platform :osx, '10.12'
  pod 'Entity/Tests', :path => 'Entity'
  pod 'Wireframe/Tests', :path => 'Wireframe'
end

# Need to list all dependencies here so CocoaPods can find them.

pod 'Entity', :path => 'Entity'
pod 'Wireframe', :path => 'Wireframe'

post_install do |installer|
  require 'cocoapods-amimono/patcher'
  Amimono::Patcher.patch!(installer)
end
