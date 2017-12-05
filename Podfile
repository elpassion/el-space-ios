source 'git@github.com:elpassion/podspecs.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'
inhibit_all_warnings!

def pod_core
    pod 'GoogleSignIn', '~> 4.0'
    pod 'RxSwift', '~> 4.0'
    pod 'RxCocoa', '~> 4.0'
    pod 'RxSwiftExt', '~> 3.0'
    pod 'ModelMapper', '~> 7.0'
    pod 'SwiftDate', '~> 4.0'
end

def pod_networking
  pod 'Alamofire', '~> 4.0'
  pod 'RxAlamofire', '~> 4.0'
end

def pod_infrastructure
    pod 'R.swift', '~> 4.0'
    pod 'Reveal-SDK', :configurations => ['Debug']
    pod 'SwiftLint', '~> 0.20'
end

def pod_el
     pod 'ELDebate', :git => 'https://github.com/elpassion/el-debate-ios.git', :commit => '649c08f'
end

def pod_ui
    pod 'Anchorage', '~> 4.0'
    pod 'HexColors', '~> 6.0'
    pod 'Pastel', '~> 0.3'
    pod 'MBProgressHUD', '~> 1.0'
    pod 'SnapKit', '~> 4.0'
end

def pod_tests
    pod 'Nimble', '~> 7.0'
    pod 'Quick', '~> 1.1'
    pod 'RxBlocking', '~> 4.0'
    pod 'RxTest', '~> 4.0'
end

target 'ELSpace' do
    use_frameworks!
    pod_core
    pod_infrastructure
    pod_el
    pod_ui
    pod_networking 
    target 'ELSpaceTests' do
        inherit! :search_paths
        pod_tests
    end
end
