import UIKit
import RxSwift

class ActivityTypeViewModel: ActivityTypeViewModeling {

    var imageSelected: UIImage = UIImage()
    var imageUnselected: UIImage = UIImage()
    var title: String = ""
    var action: Observable<Void> {
        return Observable.never()
    }

}
