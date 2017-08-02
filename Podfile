platform :ios, '10.3'

use_frameworks!

plugin 'cocoapods-amimono'

target :Remix do
  pod 'Wireframe/UIKit', :path => 'Elements/Wireframe'
  pod 'Services', :path => 'Elements/Services'
  pod 'GroupSelection/UIKit', :path => 'Elements/Features/GroupSelection'
end

target :RemixLite do
  pod 'Wireframe/UIKit', :path => 'Elements/Wireframe'
  pod 'Services', :path => 'Elements/Services'
  pod 'GroupSelection/UIKit', :path => 'Elements/Features/GroupSelection'
end

target :LogicTests do
  platform :osx, '10.12'
  pod 'Wireframe/Fakes', :path => 'Elements/Wireframe'
  pod 'Entity/Tests', :path => 'Elements/Entity'
  pod 'Services', :path => 'Elements/Services'
  pod 'GroupSelection/Tests', :path => 'Elements/Features/GroupSelection'
end

target :AcceptanceTests do
  platform :osx, '10.12'
  pod 'OCSlimProject'
  pod 'Wireframe/Fakes', :path => 'Elements/Wireframe'
  pod 'Services', :path => 'Elements/Services'
  pod 'GroupSelection/Fakes', :path => 'Elements/Features/GroupSelection'
end

pod 'Utility', :path => 'Elements/Utility'

post_install do |installer|
  require 'cocoapods-amimono/patcher'
  Amimono::Patcher.patch!(installer)
end
