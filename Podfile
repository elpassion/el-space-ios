source 'git@github.com:elpassion/podspecs.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'
inhibit_all_warnings!

def pod_core
    pod 'GoogleSignIn', '~> 4.0'
    pod 'RxSwift', '~> 3.6'
    pod 'RxCocoa', '~> 3.6'
    pod 'RxSwiftExt', '~> 2.5'
end

def pod_infrastructure
    pod 'R.swift', '~> 3.3.0'
    pod 'Reveal-SDK', :configurations => ['Debug']
    pod 'SwiftLint', '~> 0.20'
end

def pod_el
     pod 'ELDebate', '~> 1.0'
end

def pod_ui
    pod 'Anchorage', '~> 4.0'
    pod 'HexColors', '~> 5.0.1'
    pod 'Pastel', '~> 0.3.0'
end

def pod_tests
    pod 'Nimble', '~> 7.0.0'
    pod 'Quick', '~> 1.1.0'
    pod 'RxBlocking', '~> 3.6'
    pod 'RxTest', '~> 3.6'
end

target 'ELSpace' do
    use_frameworks!
    pod_core
    pod_infrastructure
    pod_el
    pod_ui
    
    target 'ELSpaceTests' do
        inherit! :search_paths
        pod_tests
    end
end
