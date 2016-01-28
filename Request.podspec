Pod::Spec.new do |s|
  s.name         = "Request"
  s.version      = "0.1.0"
  s.summary      = "Magical Networking Framework"
  s.description  = <<-DESC
                    Simple, expressive, fast, even magical, Swift networking framework.
                   DESC
  s.homepage     = "https://github.com/bradhilton/Request"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Brad Hilton" => "brad@skyvive.com" }
  s.source       = { :git => "https://github.com/bradhilton/Request.git", :tag => "0.1.0" }

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"

  s.source_files  = "Request", "Request/**/*.{swift,h,m}"
  s.requires_arc = true

  s.dependency 'Convertible', '~>0.9.0'

end
