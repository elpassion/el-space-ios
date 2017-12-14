import UIKit
import RxSwift

protocol ActivityTypeViewModeling: class {
    var type: ActivityType { get }
    var imageSelected: UIImage? { get }
    var imageUnselected: UIImage? { get }
    var title: String { get }
    var isSelected: PublishSubject<Bool> { get }
}
