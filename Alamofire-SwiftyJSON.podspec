Pod::Spec.new do |s|
  s.name        = "Alamofire-SwiftyJSON"
  s.version     = "3.0.0"
  s.summary     = "Alamofire extension for serialize NSData to SwiftyJSON "
  s.homepage    = "https://github.com/SwiftyJSON/Alamofire-SwiftyJSON"
  s.license     = { :type => "MIT" }
  s.authors     = { "tangplin" => "tangplin@gmail.com" }

  s.requires_arc = true
  s.osx.deployment_target = "10.11"
  s.ios.deployment_target = "9.0"
  s.source   = { :git => "https://github.com/SwiftyJSON/Alamofire-SwiftyJSON.git", :tag => s.version }
  s.source_files = "Source/*.swift"
  s.dependency 'Alamofire', '~> 4.5'
  s.dependency 'SwiftyJSON', '~> 4.0.0'
end
