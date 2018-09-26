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

    private var backgroundImage: UIImage? {
        let layer = gradientLayer
        var updatedFrame = navigationBar.bounds
        updatedFrame.size.height += UIApplication.shared.statusBarFrame.height
        layer.frame = updatedFrame
        UIGraphicsBeginImageContext(layer.bounds.size)
        guard let currentContext = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: currentContext)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }

    func applyHubStyle() {
        navigationBar.barTintColor = UIColor.black
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = false
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationBar.setBackgroundImage(backgroundImage, for: .default)
    }

}
