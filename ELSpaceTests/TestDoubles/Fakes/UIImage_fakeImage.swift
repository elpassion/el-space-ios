import UIKit

extension UIImage {

    static func fakeImage(width: CGFloat = 1.0, height: CGFloat = 1.0, color: UIColor = .red) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        guard let img = UIGraphicsGetImageFromCurrentImageContext() else { fatalError() }
        UIGraphicsEndImageContext()
        return img
    }

}
