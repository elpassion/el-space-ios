import UIKit
import RxSwift

class ActivityFormViewController: UIViewController, ActivityFormViewControlling, UITextFieldDelegate {

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
        configureSubviews()
        setupInputBindings()
    }

    // MARK: - ActivityFormViewControlling

    var type: AnyObserver<ActivityType> {
        return viewModel.type
    }

    // MARK: - Privates

    private let viewModel: ActivityFormViewInputModeling & ActivityFormViewOutputModeling

    private var editingTextField: UITextField? {
        didSet {
            if let inactiveTextView = oldValue?.superview as? TextView {
                inactiveTextView.separatorLine.backgroundColor = titleColorForState(false)
            }
            if let activeTextView = editingTextField?.superview as? TextView {
                activeTextView.separatorLine.backgroundColor = titleColorForState(true)
            }
        }
    }

    private let disposeBag = DisposeBag()

    private var activityFormView: ActivityFormView! {
        return view as? ActivityFormView
    }

    private func configureSubviews() {
        activityFormView.dateTextView.textField.isEnabled = false
        activityFormView.projectTextView.textField.delegate = self
        activityFormView.hoursTextView.textField.autocorrectionType = .no
        activityFormView.hoursTextView.textField.keyboardType = .decimalPad
        activityFormView.commentTextView.textField.autocorrectionType = .no
        activityFormView.commentTextView.textField.returnKeyType = .done
        activityFormView.commentTextView.textField.delegate = self
    }

    private func setupInputBindings() {
        viewModel.performedAt
            .subscribe(onNext: { [weak self] in self?.activityFormView.dateTextView.textField.text = $0 })
            .disposed(by: disposeBag)

        viewModel.projectSelected
            .subscribe(onNext: { [weak self] in self?.activityFormView.projectTextView.textField.text = $0 })
            .disposed(by: disposeBag)

        viewModel.projectInputHidden
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in self?.setHidden($0, view: self?.activityFormView.projectTextView) })
            .disposed(by: disposeBag)

        viewModel.hours
            .subscribe(onNext: { [weak self] in self?.activityFormView.hoursTextView.textField.text = $0 })
            .disposed(by: disposeBag)

        viewModel.hoursInputHidden
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in self?.setHidden($0, view: self?.activityFormView.hoursTextView) })
            .disposed(by: disposeBag)

        viewModel.comment
            .subscribe(onNext: { [weak self] in self?.activityFormView.commentTextView.textField.text = $0 })
            .disposed(by: disposeBag)

        viewModel.commentInputHidden
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in self?.setHidden($0, view: self?.activityFormView.commentTextView) })
            .disposed(by: disposeBag)
    }

    private func setHidden(_ isHidden: Bool, view: UIView?) {
        UIView.animate(withDuration: 0.25) {
            view?.isHidden = isHidden
            view?.alpha = isHidden ? 0 : 1
        }
    }

    private func titleColorForState(_ isSelected: Bool) -> UIColor? {
        return isSelected ? UIColor(color: .purpleBCAEF8) : UIColor(color: .greyB3B3B8)
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        editingTextField = textField
        if textField == activityFormView.projectTextView.textField {
            presentProjectPicker()
            return false
        } else {
            return true
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: - Helpers

    private func presentProjectPicker() {
        print("presentProjectPicker")
    }

}
