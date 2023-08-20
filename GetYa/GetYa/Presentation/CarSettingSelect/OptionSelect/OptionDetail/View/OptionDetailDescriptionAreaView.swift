//
//  OptionDetailDescriptionAreaView.swift
//  GetYa
//
//  Created by 양승현 on 2023/08/20.
//

import UIKit

final class OptionDetailDescriptionAreaView: UIView {
    enum Constants {
        static let maximumHeight: CGFloat = {
            let optionTitleMaxHeight = OptionTitleLabel.maximumLineHeight
            let optionPriceHeightAndTopMargin = OptionPriceLabel
                .topMargin + GetYaFont.custom(
                    size: 16,
                    kern: -0.2,
                    lineHeight: 24,
                    nameType: .mediumText).lineHeight
            let optionDescriptionMaximumHeight = OptionDescriptionLabel
                .maximumHeight
            let optionDescriptionTopMargin = OptionDescriptionLabel
                .topMargin
            return (optionTitleMaxHeight +
                    optionPriceHeightAndTopMargin +
                    optionDescriptionMaximumHeight +
                    optionDescriptionTopMargin)
        }()
        enum OptionTitleLabel {
            static let trailingMargin: CGFloat = .toScaledWidth(value: -12)
            /// 최대 2줄까지 옵션 제목을 보여줍니다.
            static let maximumLineHeight: CGFloat = .toScaledHeight(value: GetYaFont.mediumHead2.lineHeight*2)
        }
        enum OptionPriceLabel {
            static let topMargin: CGFloat = .toScaledHeight(value: 4)
        }
        enum OptionDescriptionLabel {
            static let topMargin: CGFloat = .toScaledHeight(value: 20)
            /// 최대 4줄까지 보여줍니다.
            static let maximumHeight: CGFloat = GetYaFont.regularBody4.lineHeight * 4
        }
    }
    // MARK: - UI properties
    private let optionTitleLabel = CommonLabel(
        fontType: .mediumHead2,
        color: .GetYaPalette.gray0,
        text: "빌트인 캠(보조배터리 포함)최대두줄까지이이이이잉이")
    private let optionPriceLabel = CommonLabel(
        fontType: .custom(size: 16, kern: -0.2, lineHeight: 24, nameType: .mediumText),
        color: .GetYaPalette.gray200,
        text: "옵션 가격 준비중...")
    private let optionSelectButton = CommonOptionSelectView(frame: .zero)
    private let optionDescriptionLabel = CommonLabel(
        fontType: .regularBody4,
        color: .GetYaPalette.gray200, text: "옵션 상세 설명이 준비중입니다...")
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    // MARK: - Private Functions
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    // MARK: - Functions
    func configure(
        optionTitle: String?,
        optionPrice: String?,
        optionDescription: String?
    ) {
        optionTitleLabel.text = optionTitle
        optionPriceLabel.text = optionPrice
        optionDescriptionLabel.text = optionDescription
    }
    // MARK: - Objc Functions
}

// MARK: - LayoutSupportable
extension OptionDetailDescriptionAreaView: LayoutSupportable {
    func setupViews() {
        addSubviews([
            optionTitleLabel,
            optionPriceLabel,
            optionSelectButton,
            optionDescriptionLabel])
    }
    
    func setupConstriants() {
        configureOptionTitleLabel()
        configureOptionPriceLabel()
        configureOptionSelectButton()
        configureOptionDescriptionLabel()
    }
    
    // MARK: - LayoutSupportable private function
    private func configureOptionTitleLabel() {
        typealias Const = Constants.OptionTitleLabel
        NSLayoutConstraint.activate([
            optionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            optionTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            optionTitleLabel.trailingAnchor.constraint(
                equalTo: optionSelectButton.leadingAnchor,
                constant: Const.trailingMargin),
            optionTitleLabel.heightAnchor.constraint(
                lessThanOrEqualToConstant: Const.maximumLineHeight)])
    }
    
    private func configureOptionPriceLabel() {
        typealias Const = Constants.OptionPriceLabel
        NSLayoutConstraint.activate([
            optionPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            optionPriceLabel.topAnchor.constraint(
                equalTo: optionTitleLabel.bottomAnchor,
                constant: Const.topMargin)])
    }
    
    private func configureOptionSelectButton() {
        NSLayoutConstraint.activate([
            optionSelectButton.topAnchor.constraint(equalTo: topAnchor),
            optionSelectButton.trailingAnchor.constraint(equalTo: trailingAnchor)])
    }
    
    private func configureOptionDescriptionLabel() {
        typealias Const = Constants.OptionDescriptionLabel
        NSLayoutConstraint.activate([
            optionDescriptionLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            optionDescriptionLabel.topAnchor.constraint(
                equalTo: optionPriceLabel.bottomAnchor,
                constant: Const.topMargin),
            optionDescriptionLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            optionDescriptionLabel.bottomAnchor.constraint(
                lessThanOrEqualTo: bottomAnchor)])
    }
}
