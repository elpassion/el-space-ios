import UIKit

extension UINavigationController {

    private var gradientLayer: CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        let bounds = navigationBar.bounds
        gradientLayer.frame = bounds
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
        updatedFrame.size.height += 20
        layer.frame = updatedFrame
        UIGraphicsBeginImageContext(layer.bounds.size)
        guard let currentContext = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: currentContext)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }

    func applayHubStyle() {
        navigationBar.barTintColor = UIColor.black
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = true
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white
        ]
        navigationBar.setBackgroundImage(backgroundImage, for: .default)
    }

}
