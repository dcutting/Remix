platform :ios, '10.3'

use_frameworks!

plugin 'cocoapods-amimono'

target :Remix do
  pod 'Wireframe/UIKit', :path => 'Wireframe'
  pod 'Entity/Core', :path => 'Entity'
  pod 'Services', :path => 'Services'
  pod 'GroupSelection/UIKit', :path => 'Features/GroupSelection'
end

target :RemixLogicTests do
  platform :osx, '10.12'
  pod 'Wireframe/Tests', :path => 'Wireframe'
  pod 'Entity/Tests', :path => 'Entity'
  pod 'Services', :path => 'Services'
  pod 'GroupSelection/Tests', :path => 'Features/GroupSelection'
end

# Need to list all dependencies here so CocoaPods can find them.

pod 'Wireframe', :path => 'Wireframe'
pod 'Entity', :path => 'Entity'
pod 'Services', :path => 'Services'
pod 'GroupSelection', :path => 'Features/GroupSelection'

post_install do |installer|
  require 'cocoapods-amimono/patcher'
  Amimono::Patcher.patch!(installer)
end
