Pod::Spec.new do |s|
  s.name         = "Utility"
  s.version      = "0.0.1"
  s.summary      = "Shared utility code"
  s.homepage     = "http://cutting.io"
  s.license      = { "type" => "MIT" }
  s.author       = "Dan Cutting"
  s.platforms    = { :ios => "10.3", :osx => "10.12" }
  s.source       = { :path => '.' }

  s.subspec "Core" do |sp|
    sp.source_files = "Core/**/*"
  end
end
