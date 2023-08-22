//
//  BaseCharacterSelectPageViewController.swift
//  GetYa
//
//  Created by 양승현 on 2023/08/16.
//

import UIKit
import Combine

protocol BaseCharacterSelectpageViewDelegate: AnyObject {
    func touchUpBaseCharacterSelectPageView(_ viewController: BaseCharacterSelectPageViewController)
}

/// 다음 버튼 누를 때 데이터를 상위 뷰한테 저장하면됩니다.
class BaseCharacterSelectPageViewController: UIViewController {
    enum Constraints {
        enum QuestionPageIndexView {
            static let topMargin: CGFloat = .toScaledHeight(value: 24)
            static let trailingMargin: CGFloat = .toScaledWidth(value: -16)
            static let height: CGFloat = .toScaledHeight(value: 40)
            static let width: CGFloat = .toScaledWidth(value: 65)
        }
        enum QuestionDescriptionLabel {
            static let leadingMargin: CGFloat = .toScaledWidth(value: 16)
            static let topMargin: CGFloat = .toScaledHeight(value: 29)
            static let trailingMargin: CGFloat = .toScaledWidth(value: -16)
            static let maximumBottomMargin: CGFloat = .toScaledHeight(value: -12)
        }
        
        enum QuestionView {
            static let topMargin: CGFloat = .toScaledHeight(value: 66)
            static let leadingMargin: CGFloat = .toScaledWidth(value: 16)
            static let trailingMargin: CGFloat = .toScaledWidth(value: -16)
            static let maximumBottomMargin: CGFloat = .toScaledHeight(value: -12)
        }
        
        enum NextButton {
            static let leadingMargin: CGFloat = .toScaledWidth(value: 16)
            static let trailingMargin: CGFloat = .toScaledWidth(value: -16)
            static let height: CGFloat = .toScaledHeight(value: 52)
        }
    }
    // MARK: - UI properties
    
    private let questionPageIndexView = QuestionNumberView()
    private let questionDescriptionLabel = CommonLabel(
        fontType: GetYaFont.regularHead2,
        color: .GetYaPalette.gray0,
        text: "질문이 준비중입니다 ...")
    private let questionView: QuestionViewSendable
    private let nextButton = CommonButton(
        font: GetYaFont.mediumBody3.uiFont,
        buttonBackgroundColorType: .primary)
    
    // MARK: - Properties
    private var questionViewTopConstriants: NSLayoutConstraint!
    private var quetsionViewheightConstriants: NSLayoutConstraint!
    private var buttonSubscription: AnyCancellable?
    var carPriceRange: (minimumValue: Int?, maximumValue: Int?) {
        questionView.sendCarMinimumAndMaximumPrice()
    }
    var selectedItemIndex: Int? {
        questionView.selectedItemIndex
    }
    
    // MARK: - Properties
    private var curPageIndex: Int
    private var totalPageIndex: Int
    var delegate: BaseCharacterSelectpageViewDelegate?
    
    // MARK: - Lifecycles
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        questionView = CharacterDetailQuestionListView(textArray: [
            "문항이 준비중입니다..",
            "당신의 차를 위한 최적의 질문지가 준비중입니다.."])
        curPageIndex = 1
        totalPageIndex = 1
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setQuestionIndexView(currentIndex: curPageIndex, totalIndex: totalPageIndex)
    }
    
    init(
        nibName nibNameOrNil: String?,
        bundle nibBundleOrNil: Bundle?,
        curPageIndex: Int,
        totalPageIndex: Int,
        questionView: QuestionViewSendable
    ) {
        self.questionView = questionView
        self.curPageIndex = curPageIndex
        self.totalPageIndex = totalPageIndex
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(
        curPageIndex: Int,
        totalPageIndex: Int,
        questionView: QuestionViewSendable
    ) {
        self.init(
            nibName: nil,
            bundle: nil,
            curPageIndex: curPageIndex,
            totalPageIndex: totalPageIndex,
            questionView: questionView)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        questionView = CharacterDetailQuestionListView(textArray: [
            "문항이 준비중입니다..",
            "당신의 차를 위한 최적의 질문지가 준비중입니다.."])
        curPageIndex = 1
        totalPageIndex = 1
        super.init(coder: coder)
        setQuestionIndexView(currentIndex: curPageIndex, totalIndex: totalPageIndex)
    }
    
    // MARK: - Private Functions
    private func configureUI() {
        setupUI()
        nextButton.setTitle("다음", for: .normal)
    }
    
    private func bind() {
        buttonSubscription = nextButton.tap.sink {
            self.delegate?.touchUpBaseCharacterSelectPageView(self)
        }
    }
    
    // MARK: - Functions
    func setQuestionIndexView(currentIndex: Int, totalIndex: Int) {
        questionPageIndexView.setText(text: "\(currentIndex)/\(totalIndex)")
    }
    
    func setNextButtonTitle(with title: String) {
        nextButton.setTitle(title, for: .normal)
    }
    
    func setQuestionDescriptionLabel(
        defaultText: String,
        otherFontType: GetYaFont = .mediumHead2,
        highlightText: String
    ) {
        questionDescriptionLabel.text = defaultText
        questionDescriptionLabel.configurePartTextFont(otherFontType: otherFontType, partText: highlightText)
    }
    
    func configureTopMargin(with margin: CGFloat) {
        questionViewTopConstriants.isActive = false
        questionViewTopConstriants = questionView.topAnchor.constraint(
            equalTo: questionPageIndexView.bottomAnchor,
            constant: margin)
        questionViewTopConstriants.isActive = true
        view.layoutIfNeeded()
    }
    
    func configureHeightMargin(with height: CGFloat) {
        if quetsionViewheightConstriants != nil {
            quetsionViewheightConstriants.isActive = false
        }
        quetsionViewheightConstriants = questionView.heightAnchor.constraint(
            equalToConstant: height)
        quetsionViewheightConstriants.isActive = true
        view.layoutIfNeeded()
    }
    
    func setupNextButtonToCompletion() {
        nextButton.setTitle("완료", for: .normal)
    }
}

// MARK: - LayoutSupportable
extension BaseCharacterSelectPageViewController: LayoutSupportable {
    func setupViews() {
        view.addSubviews([
            questionPageIndexView,
            questionDescriptionLabel,
            questionView,
            nextButton])
    }
    
    func setupConstriants() {
        configureQuestionIndexView()
        configureQuestionDescriptionLabel()
        configureQuestionView()
        configureNextButton()
    }
    
    private func configureQuestionIndexView() {
        typealias Const = Constraints.QuestionPageIndexView
        NSLayoutConstraint.activate([
            questionPageIndexView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Const.trailingMargin),
            questionPageIndexView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: Const.topMargin),
            questionPageIndexView.widthAnchor.constraint(
                equalToConstant: Const.width),
            questionPageIndexView.heightAnchor.constraint(
                equalToConstant: Const.height)])
    }
    
    private func configureQuestionDescriptionLabel() {
        typealias Const = Constraints.QuestionDescriptionLabel
        NSLayoutConstraint.activate([
            questionDescriptionLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Const.leadingMargin),
            questionDescriptionLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: Const.topMargin),
            questionDescriptionLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Const.trailingMargin),
            questionDescriptionLabel.bottomAnchor.constraint(
                lessThanOrEqualTo: questionView.topAnchor,
                constant: Const.maximumBottomMargin)])
    }

    private func configureQuestionView() {
        typealias Const = Constraints.QuestionView
        questionViewTopConstriants = questionView.topAnchor.constraint(
            equalTo: questionPageIndexView.bottomAnchor,
            constant: Const.topMargin)
        
        NSLayoutConstraint.activate([
            questionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Const.leadingMargin),
            questionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Const.trailingMargin),
            questionViewTopConstriants,
            questionView.bottomAnchor.constraint(
                lessThanOrEqualTo: nextButton.topAnchor,
                constant: Const.maximumBottomMargin)])
    }
    
    private func configureNextButton() {
        typealias Const = Constraints.NextButton
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Const.leadingMargin),
            nextButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Const.trailingMargin),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: Const.height)])
    }
}
