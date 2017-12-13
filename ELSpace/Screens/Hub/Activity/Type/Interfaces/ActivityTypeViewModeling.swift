import UIKit
import RxSwift

protocol ActivityTypeViewModeling {
    var imageSelected: UIImage { get }
    var imageUnselected: UIImage { get }
    var title: String { get }
}
