import UIKit

extension UINavigationController {

    private var gradientLayer: CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(color: .purpleCEC1FF).cgColor,
            UIColor(color: .purpleAB9BFF).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        return gradientLayer
    }

    private func backgroundImage(for size: CGSize) -> UIImage? {
        let layer = gradientLayer
        layer.frame = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(layer.bounds.size)
        guard let currentContext = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: currentContext)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
    
    private var systemTopBarsSize: CGSize {
        var size = CGSize.zero
        
        if #available(iOS 11.0, *) {
            size.height = topViewController?.view.safeAreaInsets.top ?? navigationBar.frame.height
        } else {
            size.height = navigationBar.frame.height
        }
        size.width = navigationBar.frame.width
        return size
    }

    func applyHubStyle() {
        navigationBar.barTintColor = UIColor.black
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = false
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        navigationBar.setBackgroundImage(backgroundImage(for: systemTopBarsSize), for: .default)
    }

}
