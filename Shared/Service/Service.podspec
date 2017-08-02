Pod::Spec.new do |s|
  s.name         = "Service"
  s.version      = "0.0.1"
  s.summary      = "Shared services and gateways"
  s.homepage     = "http://cutting.io"
  s.license      = { "type" => "MIT" }
  s.author       = "Dan Cutting"
  s.platforms    = { :ios => "10.3", :osx => "10.12" }
  s.source       = { :path => '.' }

  s.subspec "AdvertService" do |sp|
    sp.source_files = "AdvertService/**/*"
    sp.dependency "Utility/Core"
    sp.dependency "Entity/Core"
  end

  s.subspec "GroupService" do |sp|
    sp.source_files = "GroupService/**/*"
    sp.dependency "Utility/Core"
    sp.dependency "Entity/Core"
  end
end
