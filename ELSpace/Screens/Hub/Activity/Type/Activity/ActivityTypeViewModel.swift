import UIKit
import RxSwift

class ActivityTypeViewModel: ActivityTypeViewModeling {

    var imageSelected: UIImage = UIImage()
    var imageUnselected: UIImage = UIImage()
    var title: String = ""
    var isSelected: Observable<Bool> = PublishSubject<Bool>().asObservable()
    var select: AnyObserver<Void> {
        return AnyObserver(eventHandler: { _ in })
    }

}
