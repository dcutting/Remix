Pod::Spec.new do |s|
  s.name         = "Wireframe"
  s.version      = "0.0.1"
  s.summary      = "Wireframe abstractions for coordinators"
  s.homepage     = "http://cutting.io"
  s.license      = { "type" => "MIT" }
  s.author       = "Dan Cutting"
  s.platforms    = { :ios => "10.3", :osx => "10.12" }
  s.source       = { :path => '.' }

  s.subspec "Core" do |sp|
    sp.source_files = "Source/**/*"
  end

  s.subspec "Tests" do |sp|
    sp.platform = :osx, "10.12"
    sp.framework = 'XCTest'
    sp.source_files = "Tests"
    sp.dependency "Wireframe/Core"
    sp.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
  end
end
