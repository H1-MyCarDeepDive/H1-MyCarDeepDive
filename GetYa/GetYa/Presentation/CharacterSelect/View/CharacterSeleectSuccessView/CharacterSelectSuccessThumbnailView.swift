//
//  CharacterSelectSuccessThumbnailView.swift
//  GetYa
//
//  Created by 양승현 on 2023/08/07.
//

import UIKit

final class CharacterSelectSuccessThumbnailView: UIView {
    // MARK: - Constant
    enum Constant {
        static let layerColors: [UIColor] = [
            UIColor(red: 0.9, green: 0.92, blue: 0.94, alpha: 1),
            UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)]
        enum RecommendKeywordStackView {
            static let uiConstant: UILayout = .init(
             leadingMargin: 16, topMargin: 41)
            static let interItemSpacing: CGFloat = 6
            static let height: CGFloat = UILayout.init(height: 28).height
        }
        enum TagView {
            static let textColor: UIColor = .GetYaPalette.gray300
            static let height: CGFloat = UILayout.init(height: 28).height
            static let cornerRadius: CGFloat = height/2
            static let font: GetYaFont = GetYaFont.regularCaption1
            static let borderWidth: CGFloat = 1
            static let borderColor: UIColor = .GetYaPalette.gray300
        }
        enum RecommendDiscriptionView {
            static let uiConstant: UILayout = .init(
                leadingMargin: 16, topMargin: 16)
            static let font: GetYaFont = .boldHead1
            static let fontColor: UIColor = .GetYaPalette.gray0
        }
        enum RecommendSubDiscriptionView {
            static let uiConstant: UILayout = .init(
                leadingMargin: 16, topMargin: 4)
            static let font: GetYaFont = .mediumHead2
            static let fontColor: UIColor = .GetYaPalette.gray200
        }
        enum RecommendCarImageView {
            static let uiConstant: UILayout = .init(
                leadingMargin: 62, topMargin: 145, bottomMargin: 11)
            static let imageName: String = "characterSelectSuccessCar"
        }
        enum RecommendCarBackgroundView {
            static let height: CGFloat = UILayout.init(height: 131).height
            static let bgColor: UIColor = .GetYaPalette.gray300
        }
    }
    // MARK: - UI properties
    private let recommendKeywordStackView: UIStackView = .init(arrangedSubviews: []).set {
        let const = Constant.RecommendKeywordStackView.self
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = const.interItemSpacing
        $0.distribution = .fillEqually
    }
    private let recommendDiscriptionView: CommonLabel = .init(
        font: Constant.RecommendDiscriptionView.font.uiFont,
        color: Constant.RecommendDiscriptionView.fontColor,
        text: "질문에 기반한 추천 차량이에요"
    ).set { $0.translatesAutoresizingMaskIntoConstraints = false }
    private let recommendSubDiscriptionView: CommonLabel = .init(
        font: Constant.RecommendSubDiscriptionView.font.uiFont,
        color: Constant.RecommendSubDiscriptionView.fontColor,
        text: "전국의 Car master 분들이 엄선하여 추천했어요")
    private let recommendCarImageView = UIImageView(
        image: .init(named: Constant.RecommendCarImageView.imageName)
    ).set {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
    }
    private let recommendCarBackgroundView = UIView(frame: .zero).set {
        let const = Constant.RecommendCarBackgroundView.self
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = const.bgColor
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureSubviewUI(
            with: recommendKeywordStackView,
            recommendDiscriptionView,
            recommendSubDiscriptionView,
            recommendCarImageView,
            recommendCarBackgroundView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
}

// MARK: - Helper
extension CharacterSelectSuccessThumbnailView {
    func configureUI() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = Constant.layerColors
        layer.insertSublayer(gradient, at: 0)
    }
    
    func setRecommendKeywordStackView(_ texts: [String]) {
        let const = Constant.TagView.self
        // TODO: 폰트색 변경해야함
        _=texts.map { text in
            recommendKeywordStackView.addArrangedSubview(TagView(text: text).set {
                $0.configureCornerRadius(with: const.cornerRadius)
                $0.configureBorderWidth(with: const.borderWidth)
                $0.configureBorderColor(with: const.borderColor)
            })
        }
    }
}

// MARK: - LayoutSupportable
extension CharacterSelectSuccessThumbnailView: LayoutSupportable {
    func configureConstraints() {
        [recommendKeywordStackViewConstraints
         recommendDiscriptionViewConstraints
         recommendSubDiscriptionViewConstraints
         recommendCarImageViewConstraints
         recommendCarBackgroundViewConstraints].map {
            NSLayoutConstraint.activate($0)
        }
    }
}

