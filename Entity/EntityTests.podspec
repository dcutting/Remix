Pod::Spec.new do |s|
  s.name         = "EntityTests"
  s.version      = "0.0.1"
  s.summary      = "Shared entity models and logic"
  s.homepage     = "http://cutting.io"
  s.license      = { "type" => "MIT" }
  s.author       = "Dan Cutting"
  s.source       = { :path => '.' }
  s.platform = :osx, "10.12"
  s.framework = 'XCTest'
  s.source_files = "Tests/**/*"
  s.dependency "Entity"
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
end
