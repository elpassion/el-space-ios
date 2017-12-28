import UIKit
import RxSwift

class ChooserActivityTypesViewController: UIViewController, ChooserActivityTypesViewControlling {

    init(viewModel: ChooserActivityTypesViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = ChooserActivityTypesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addActivityTypes()
    }

    // MARK: ActivityTypeViewControlling

    var selected: Observable<ActivityType> {
        return selectedTypeSubject.asObservable()
    }

    var select: AnyObserver<ActivityType> {
        return AnyObserver(eventHandler: { [weak self] event in
            guard let type = event.element else { return }
            let reportTypeViewModel = self?.viewModel.activityTypeViewModels.filter { $0.type == type }.first
            reportTypeViewModel?.isSelected.onNext(true)
        })
    }

    // MARK: Privates

    private let viewModel: ChooserActivityTypesViewModeling
    private let selectedTypeSubject = PublishSubject<ActivityType>()
    private let disposeBag = DisposeBag()

    private var activityTypesView: ChooserActivityTypesView! {
        return view as? ChooserActivityTypesView
    }

    private func addActivityTypes() {
        activityTypesView.typeViews = createActivityTypeViews()
    }

    private func createActivityTypeViews() -> [ActivityTypeView] {
        return viewModel.activityTypeViewModels.map { viewModel in
            let view = ActivityTypeView()
            view.titleLabel.text = viewModel.title
            view.titleLabel.textColor = self.titleColorForState(false)
            view.imageView.image = viewModel.imageUnselected
            viewModel.isSelected
                .subscribe(onNext: { [weak view, weak self] isSelected in
                    view?.imageView.image = isSelected ? viewModel.imageSelected : viewModel.imageUnselected
                    view?.titleLabel.textColor = self?.titleColorForState(isSelected)
                    if isSelected { self?.selectedTypeSubject.onNext(viewModel.type) }
                })
                .disposed(by: disposeBag)
            view.button.rx.tap
                .map { true }
                .bind(to: viewModel.isSelected)
                .disposed(by: disposeBag)
            return view
        }
    }

    private func titleColorForState(_ isSelected: Bool) -> UIColor? {
        return isSelected ? UIColor(color: .purpleBCAEF8) : UIColor(color: .grayB3B3B8)
    }

}
