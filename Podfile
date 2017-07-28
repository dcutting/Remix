platform :ios, '10.3'

use_frameworks!

plugin 'cocoapods-amimono'

target :Remix do
  pod 'Wireframe/UIKit', :path => 'Wireframe'
  pod 'Services', :path => 'Services'
  pod 'GroupSelection/UIKit', :path => 'Features/GroupSelection'
end

target :RemixLite do
  pod 'Wireframe/UIKit', :path => 'Wireframe'
  pod 'Services', :path => 'Services'
  pod 'GroupSelection/UIKit', :path => 'Features/GroupSelection'
end

target :LogicTests do
  platform :osx, '10.12'
  pod 'Wireframe/Fakes', :path => 'Wireframe'
  pod 'Entity/Tests', :path => 'Entity'
  pod 'Services', :path => 'Services'
  pod 'GroupSelection/Tests', :path => 'Features/GroupSelection'
end

target :AcceptanceTests do
  platform :osx, '10.12'
  pod 'OCSlimProject'
  pod 'Wireframe/Fakes', :path => 'Wireframe'
  pod 'Services', :path => 'Services'
  pod 'GroupSelection/Fakes', :path => 'Features/GroupSelection'
end

post_install do |installer|
  require 'cocoapods-amimono/patcher'
  Amimono::Patcher.patch!(installer)
end
