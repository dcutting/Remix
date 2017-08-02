platform :ios, '10.3'

use_frameworks!

plugin 'cocoapods-amimono'

target :Remix do
  pod 'Wireframe/UIKit', :path => 'Shared/Wireframe'
  pod 'Services', :path => 'Shared/Services'
  pod 'GroupSelection/UIKit', :path => 'Shared/Features/GroupSelection'
end

target :RemixLite do
  pod 'Wireframe/UIKit', :path => 'Shared/Wireframe'
  pod 'Services', :path => 'Shared/Services'
  pod 'GroupSelection/UIKit', :path => 'Shared/Features/GroupSelection'
end

target :LogicTests do
  platform :osx, '10.12'
  pod 'Wireframe/Fakes', :path => 'Shared/Wireframe'
  pod 'Entity/Tests', :path => 'Shared/Entity'
  pod 'Services', :path => 'Shared/Services'
  pod 'GroupSelection/Tests', :path => 'Shared/Features/GroupSelection'
end

target :AcceptanceTests do
  platform :osx, '10.12'
  pod 'OCSlimProject'
  pod 'Wireframe/Fakes', :path => 'Shared/Wireframe'
  pod 'Services', :path => 'Shared/Services'
  pod 'GroupSelection/Fakes', :path => 'Shared/Features/GroupSelection'
end

pod 'Utility', :path => 'Shared/Utility'

post_install do |installer|
  require 'cocoapods-amimono/patcher'
  Amimono::Patcher.patch!(installer)
end
