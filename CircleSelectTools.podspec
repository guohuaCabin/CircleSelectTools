#
# Be sure to run `pod lib lint CircleSelectTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CircleSelectTools'
  s.version          = '0.1.0'
  s.summary          = 'A short description of CircleSelectTools.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/guohuaCabin/CircleSelectTools'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'guohuaden@163.com' => 'name_guohua@163.com' }
  s.source           = { :git => 'git@github.com:guohuaCabin/CircleSelectTools.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'CircleSelectTools/Classes/**/*'
  s.static_framework  =  true
  
  s.source_files = 'CircleSelectTools/Classes/*.{h,m}'
  
  s.resources = ['CircleSelectTools/Assets/*.xcassets','CircleSelectTools/Assets/Audio/*.mp3', 'KKLShellKit/Assets/Font/*.{otf, ttf,TTF}','CircleSelectTools/Assets/Plist/*.plist']
  
  #s.public_header_files = ['CircleSelectTools/Classes/ShellKit.h','KKLShellKit/Classes/SKAppDelegate.h','KKLShellKit/Classes/SKApplicationDelegateProtocol.h','KKLShellKit/Classes/SKContext.h','KKLShellKit/Classes/SKDefines.h','SKAppDelegate+ExtraSettings.h']
  
  # s.resource_bundles = {
  #   'CircleSelectTools' => ['CircleSelectTools/Assets/*.png']
  # }

    s.dependency 'Bugly', '2.5.0'
    s.dependency 'UMCCommon'
    s.dependency 'XHXRouter'
    s.dependency 'KKLThirdParty/Static'
    s.dependency 'XHXKit'
    s.dependency 'CKKit'
    s.dependency 'XHXLog'
    
    s.dependency 'XHXNetwork'
    s.dependency 'KKLUIKit'
    
    ss.vendored_frameworks = 'CircleSelectTools/PTFakeTouchFramework/*.framework'
end
