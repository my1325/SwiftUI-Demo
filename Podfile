source "https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git" 
inhibit_all_warnings!

workspace 'SwiftUI-Demos.xcworkspace'

target 'YDS' do 
  project 'YDS/YDS.xcodeproj'
  use_frameworks!

  pod 'Moya'
  pod 'Moya/RxSwift' 	

 #配置pod库的bitcode等编译设置
 post_install do |installer_representation|
     installer_representation.pods_project.build_configurations.each do |config|
         config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
         config.build_settings['SDKROOT'] = 'iphoneos'
         config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
         config.build_settings['ENABLE_BITCODE'] = 'NO'
         config.build_settings['VALID_ARCHS'] = 'arm64 arm64e armv7s armv7'
     end
 end
end 