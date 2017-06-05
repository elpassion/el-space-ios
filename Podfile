platform :ios, '10.0'
inhibit_all_warnings!

def helpers
    pod 'Anchorage', '~> 4.0'
    pod 'UIColor_Hex_Swift', '~> 3.0.2'
    pod "Pastel", '~> 0.3.0'
    pod 'R.swift', '~> 3.3.0'
    pod 'Reveal-SDK', :configurations => ['Debug']
    pod 'SwiftLint', '~> 0.18'
end



target 'ELSpace' do
    helpers
    use_frameworks!
    
    target 'ELSpaceTests' do
        inherit! :search_paths
        
    end
    
end
