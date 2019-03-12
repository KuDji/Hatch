Pod::Spec.new do |spec|

  spec.name         = "Hatch"
  spec.version      = "1.0.10"
  spec.summary      = "Hatch custom alerts."
  spec.homepage     = "https://github.com/KuDji/Hatch"
  spec.description  = <<-DESC
			Modeling rhino style Alerts
                   DESC
  spec.license      = "MIT"
  spec.author       = "kudjij@gmail.com"
  spec.source       = { :git => 'https://github.com/KuDji/Hatch.git', :tag => spec.version }

  spec.ios.deployment_target = "10.0"
  spec.swift_version = "4.2"

  spec.source_files = 'Source/*.swift'

  spec.dependency 'SnapKit'

end
