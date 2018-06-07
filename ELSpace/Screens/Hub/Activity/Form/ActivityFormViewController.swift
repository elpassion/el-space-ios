import UIKit
import RxSwift

protocol ActivityFormViewControlling {
    var type: AnyObserver<ActivityType> { get }
    var form: Observable<ActivityForm> { get }
}

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
        setInitialState()
        setupInputBindings()
        setupOutputBindings()
    }

    // MARK: - ActivityFormViewControlling

    var type: AnyObserver<ActivityType> {
        return viewModel.type
    }

    var form: Observable<ActivityForm> {
        return viewModel.form
    }

    // MARK: - Privates

    private let viewModel: ActivityFormViewInputModeling & ActivityFormViewOutputModeling

    private var editingTextField: UITextField? {
        didSet {
            if let inactiveTextView = oldValue?.superview as? TextView {
                inactiveTextView.separatorLine.backgroundColor = titleColorForState(false)
                inactiveTextView.endEditing(true)
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
        activityFormView.projectTextView.textField.delegate = self
        activityFormView.hoursTextView.textField.delegate = self
        activityFormView.commentTextView.textField.delegate = self
    }

    private func setInitialState() {
        activityFormView.dateTextView.separatorLine.backgroundColor = titleColorForState(false)
        activityFormView.projectTextView.separatorLine.backgroundColor = titleColorForState(false)
        activityFormView.pickerView.isHidden = true
        activityFormView.hoursTextView.separatorLine.backgroundColor = titleColorForState(false)
        activityFormView.commentTextView.separatorLine.backgroundColor = titleColorForState(false)
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
            .subscribe(onNext: { [weak self] in
                self?.setHidden($0, view: self?.activityFormView.projectTextView)
                self?.setProjectPickerHidden(true)
            })
            .disposed(by: disposeBag)

        viewModel.hours
            .subscribe(onNext: { [weak self] in self?.activityFormView.hoursTextView.textField.text = $0 })
            .disposed(by: disposeBag)

        viewModel.hoursInputHidden
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.setHidden($0, view: self?.activityFormView.hoursTextView)
                if $0 { self?.editingTextField = nil }
            })
            .disposed(by: disposeBag)

        viewModel.comment
            .subscribe(onNext: { [weak self] in self?.activityFormView.commentTextView.textField.text = $0 })
            .disposed(by: disposeBag)

        viewModel.commentInputHidden
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.setHidden($0, view: self?.activityFormView.commentTextView)
                if $0 { self?.editingTextField = nil }
            })
            .disposed(by: disposeBag)

        viewModel.projectNames
            .bind(to: activityFormView.pickerView.rx.itemTitles) { _, item in return item }
            .disposed(by: disposeBag)

        activityFormView.pickerView.rx.modelSelected(String.self)
            .map { $0.first }
            .unwrap()
            .bind(to: viewModel.selectProject)
            .disposed(by: disposeBag)
    }

    private func setupOutputBindings() {
        activityFormView.hoursTextView.textField.rx.text
            .unwrap()
            .bind(to: viewModel.updateHours)
            .disposed(by: disposeBag)

        activityFormView.commentTextView.textField.rx.text
            .unwrap()
            .bind(to: viewModel.updateComment)
            .disposed(by: disposeBag)
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let isProjectField = textField == activityFormView.projectTextView.textField
        setProjectPickerHidden(!isProjectField)
        if isProjectField { editingTextField = nil }
        return !isProjectField
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        editingTextField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        editingTextField = nil
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        editingTextField = nil
        return true
    }

    // MARK: - Helpers

    private func setProjectPickerHidden(_ isHidden: Bool) {
        if activityFormView.pickerView.isHidden != isHidden {
            setHidden(isHidden, view: activityFormView.pickerView)
            activityFormView.projectTextView.separatorLine.backgroundColor = titleColorForState(!isHidden)
        }
    }

    private func setHidden(_ isHidden: Bool, view: UIView?) {
        UIView.animate(withDuration: 0.25) {
            view?.isHidden = isHidden
            view?.alpha = isHidden ? 0 : 1
        }
    }

    private func titleColorForState(_ isSelected: Bool) -> UIColor? {
        return isSelected ? UIColor(color: .purpleBCAEF8) : UIColor(color: .grayB3B3B8)
    }

}
