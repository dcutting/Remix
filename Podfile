platform :ios, '10.3'

use_frameworks!

plugin 'cocoapods-amimono'

target :Marketplace do
  pod 'Wireframe/UIKit', :path => 'Shared/Wireframe'
  pod 'Service', :path => 'Shared/Service'
  pod 'GroupSelectionFeature/UIKit', :path => 'Shared/GroupSelectionFeature'
end

target :GroupBrowser do
  pod 'Wireframe/UIKit', :path => 'Shared/Wireframe'
  pod 'Service', :path => 'Shared/Service'
  pod 'GroupSelectionFeature/UIKit', :path => 'Shared/GroupSelectionFeature'
end

target :LogicTests do
  platform :osx, '10.12'
  pod 'Wireframe/Fakes', :path => 'Shared/Wireframe'
  pod 'Entity/Tests', :path => 'Shared/Entity'
  pod 'Service', :path => 'Shared/Service'
  pod 'GroupSelectionFeature/Tests', :path => 'Shared/GroupSelectionFeature'
end

target :AcceptanceTests do
  platform :osx, '10.12'
  pod 'OCSlimProject'
  pod 'Wireframe/Fakes', :path => 'Shared/Wireframe'
  pod 'Service', :path => 'Shared/Service'
  pod 'GroupSelectionFeature/Fakes', :path => 'Shared/GroupSelectionFeature'
end

pod 'Utility', :path => 'Shared/Utility'

post_install do |installer|
  require 'cocoapods-amimono/patcher'
  Amimono::Patcher.patch!(installer)
end
