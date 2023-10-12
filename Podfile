# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'FetchEvents' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for FetchEvents
  pod 'Kingfisher', '~> 6.0'
  pod 'CRRefresh'
  
#   https://stackoverflow.com/questions/75574268/missing-file-libarclite-iphoneos-a-xcode-14-3
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      end
    end
  end
  
end
