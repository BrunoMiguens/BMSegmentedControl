Pod::Spec.new do |s|
  s.name                      = "BMSegmentedControl"
  s.version                   = "0.2.0"
  s.source                    = { :git => "https://github.com/BrunoMiguens/BMSegmentedControl.git",
                                  :tag => s.version.to_s }

  s.summary                   = "Segmented control with image and title."
  s.description               = "This is a custom Segmented Control with icon and text on every segment."
  s.homepage                  = "https://github.com/dwipp/BMSegmentedControl"
  s.license                   = { :type => "MIT", :file => "LICENSE" }
  s.author                    = 'BrunoMiguens'

  s.ios.deployment_target     = "8.0"
  s.source_files              = "DPSegmentedControl/**/*.swift"
  s.requires_arc              = true
end
