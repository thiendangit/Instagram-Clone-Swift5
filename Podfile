# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'InstagramClone-Swift5' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks! :linkage => :static
  
  # Pods for InstagramClone-Swift5
  
  #Appirater
  pod "Appirater"
  #Firebase
  pod 'Firebase/Auth'
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Storage'
  #SDWebImage
  pod 'SDWebImage'
  pod 'ReadMoreTextView'
  pod 'SnapKit', '~> 5.0.0'
  pod 'lottie-ios'
  pod 'FlexiblePageControl'

  post_install do |installer|
      installer.pods_project.build_configurations.each do |config|
          config.build_settings.delete('CODE_SIGNING_ALLOWED')
          config.build_settings.delete('CODE_SIGNING_REQUIRED')
      end
  end
  
end
