import UIKit
import RxSwift

class ActivityFormViewController: UIViewController, ActivityFormViewControlling {

    init(viewModel: ActivityFormViewInputModeling & ActivityFormViewOutputModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = ActivityFormView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputBindings()
    }

    // MARK: - ActivityFormViewControlling

    var type: AnyObserver<ActivityType> {
        return viewModel.type
    }

    // MARK: - Privates

    private let viewModel: ActivityFormViewInputModeling & ActivityFormViewOutputModeling

    private let disposeBag = DisposeBag()

    private var activityFormView: ActivityFormView! {
        return view as? ActivityFormView
    }

    private func setupInputBindings() {
        viewModel.performedAt
            .subscribe(onNext: { [weak self] in self?.activityFormView.dateTextView.textField.text = $0 })
            .disposed(by: disposeBag)

        viewModel.projectSelected
            .subscribe(onNext: { [weak self] in self?.activityFormView.projectTextView.textField.text = $0 })
            .disposed(by: disposeBag)

        viewModel.projectInputHidden
            .subscribe(onNext: { [weak self] in self?.setHidden($0, view: self?.activityFormView.projectTextView) })
            .disposed(by: disposeBag)

        viewModel.hours
            .subscribe(onNext: { [weak self] in self?.activityFormView.hoursTextView.textField.text = $0 })
            .disposed(by: disposeBag)

        viewModel.hoursInputHidden
            .subscribe(onNext: { [weak self] in self?.setHidden($0, view: self?.activityFormView.hoursTextView) })
            .disposed(by: disposeBag)

        viewModel.comment
            .subscribe(onNext: { [weak self] in self?.activityFormView.commentTextView.textField.text = $0 })
            .disposed(by: disposeBag)

        viewModel.commentInputHidden
            .subscribe(onNext: { [weak self] in self?.setHidden($0, view: self?.activityFormView.commentTextView) })
            .disposed(by: disposeBag)
    }

    private func setHidden(_ isHidden: Bool, view: UIView?) {
        view?.isHidden = isHidden
    }

    private func titleColorForState(_ isSelected: Bool) -> UIColor? {
        return isSelected ? UIColor(color: .purpleBCAEF8) : UIColor(color: .greyB3B3B8)
    }

}
