#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_qiniu.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_qiniu'
  s.version          = '0.0.1'
  s.summary          = 'flutter Qiniu Upload plugin'
  s.description      = <<-DESC
flutter Qiniu Upload plugin.
                       DESC
  s.homepage         = 'https://github.com/xiaoenai/flutter_qiniu'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'Qiniu', '~> 7.4'


  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }

end
