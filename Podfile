source 'git@github.com:elpassion/podspecs.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'
inhibit_all_warnings!

def helpers
    pod 'Anchorage', '~> 4.0'
    pod 'HexColors', '~> 5.0.1'
    pod 'Pastel', '~> 0.3.0'
    pod 'R.swift', '~> 3.3.0'
    pod 'Reveal-SDK', :configurations => ['Debug']
    pod 'SwiftLint', '~> 0.20'
    pod 'Google/SignIn'
    pod 'RxSwift', '~> 3.6'
    pod 'RxCocoa', '~> 3.6'
    pod 'RxSwiftExt', '~> 2.5'
    pod 'RxBlocking', '~> 3.6'
end

def elPods
     pod 'ELDebate', '~> 1.0'
end

def test_helpers
    pod 'Nimble', '~> 7.0.0'
    pod 'Quick', '~> 1.1.0'
end

target 'ELSpace' do
    helpers
    elPods
    use_frameworks!
    
    target 'ELSpaceTests' do
        inherit! :search_paths
        test_helpers
    end
end
