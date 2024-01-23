#
# Be sure to run `pod lib lint KahLUA.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KahLUA'
  s.version          = '1.0.5'
  s.summary          = 'KahLUA'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'This is the private KahLUA used by Appknot.'

  s.homepage         = 'https://github.com/appknot/KahLUA'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'woody-iOS' => 'woody@appknot.com' }
  s.source           = { :git => 'https://github.com/appknot/KahLUA.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'KahLUA/Classes'
  
  s.subspec 'BaseComponent' do |ss|
      ss.source_files = 'KahLUA/Classes/BaseComponent/*'
  end
  
  s.subspec 'Bxtension' do |ss|
      ss.source_files = 'KahLUA/Classes/Extension/*'
  end
  
  # s.resource_bundles = {
  #   'KahLUA' => ['KahLUA/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
