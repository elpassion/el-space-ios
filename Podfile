platform :ios, '10.0'
inhibit_all_warnings!

def helpers
    pod 'Anchorage', '~> 4.0'
    pod 'HexColors', '~> 5.0.1'
    pod 'Pastel', '~> 0.3.0'
    pod 'R.swift', '~> 3.3.0'
    pod 'Reveal-SDK', :configurations => ['Debug']
    pod 'SwiftLint', '~> 0.18'
    pod 'Google/SignIn'
end

target 'ELSpace' do
    helpers
    use_frameworks!
    
    target 'ELSpaceTests' do
        inherit! :search_paths
        
    end
    
end
