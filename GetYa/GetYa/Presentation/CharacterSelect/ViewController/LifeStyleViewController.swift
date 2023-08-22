//
//  LifeStyleViewController.swift
//  GetYa
//
//  Created by 배남석 on 2023/08/06.
//

import UIKit

protocol LifeStyleViewControllerDelegate: AnyObject {
    func touchUpSuccessButton(sender: UIButton)
}

class LifeStyleViewController: UIViewController {
    enum Constants {
        enum CollectionView {
            static let topMargin: CGFloat = .toScaledHeight(value: 43)
            static let height: CGFloat = .toScaledHeight(value: 320)
            static let cellSpacing: CGFloat = .toScaledWidth(value: 8)
        }
        enum Cell {
            static let height: CGFloat = .toScaledHeight(value: 320)
            static let width: CGFloat = .toScaledWidth(value: 278)
        }
        enum PageControl {
            static let topMargin: CGFloat = .toScaledHeight(value: 32)
        }
    }
    
    // MARK: - UI Properties
    private let contentView = QuestionContentView()
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createCollectionViewLayout()
    )
    private lazy var pageControl = CommonPageControl(numberOfPages: tagTexts.count + 1)
    
    // MARK: - Properties
    weak var delegate: LifeStyleViewControllerDelegate?
    let descriptionTexts: [String] = [
        "가족과 함께 타서 안전을\n중시해요",
        "매일 출퇴근하여 경제적이고\n편안한 주행을 원해요",
        "운전 경력이 짧아\n똑똑한 주행을 원해요",
        "트렌드에 민감해\n디자인과 성능이 중요해요"
    ]
    let tagTexts: [[String]] = [
        ["#주행안전", "#사용편의"],
        ["#사용편의", "#추위/더위"],
        ["#주행안전", "#주차/출차"],
        ["#스타일", "#퍼포먼스"]
    ]
    let titleImages: [UIImage?] = [
        UIImage(named: "family"),
        UIImage(named: "businessman"),
        UIImage(named: "junior"),
        UIImage(named: "trendy")
    ]
    private var selectedIndexPath: IndexPath? {
        didSet {
            contentView.setButtonIsEnabled(isEnabled: selectedIndexPath == nil ? false : true)
        }
    }
    
    // MARK: - LifeCycles
    override func loadView() {
        contentView.configureDetail(
            descriptionText: "유사한 라이프스타일을 선택하면\n차량을 추천해 드려요.",
            partText: "라이프스타일",
            questionNumber: 2,
            questionCount: 2,
            buttonTitle: "선택 완료"
        )
        contentView.setButtonIsEnabled(isEnabled: false)
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        configureUI()
        contentView.delegate = self
    }
    
    // MARK: - Functions
    private func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: Constants.Cell.width, height: Constants.Cell.height)
        flowLayout.minimumLineSpacing = Constants.CollectionView.cellSpacing
        flowLayout.minimumInteritemSpacing = Constants.CollectionView.cellSpacing
        flowLayout.scrollDirection = .horizontal
        
        return flowLayout
    }
    
    private func setupViews() {
        contentView.addSubviews([
            collectionView,
            pageControl
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        configureCollectionView()
        configurePageControl()
    }
    
    private func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            LifeStyleCell.self,
            forCellWithReuseIdentifier: LifeStyleCell.identifier)
        collectionView.register(
            LifeStyleDetailCell.self,
            forCellWithReuseIdentifier: LifeStyleDetailCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = false
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        let insetX = (UIScreen.main.bounds.width - Constants.Cell.width) / 2.0
        collectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: contentView.descriptionLabel.bottomAnchor,
                constant: Constants.CollectionView.topMargin),
            collectionView.heightAnchor.constraint(
                equalToConstant: Constants.CollectionView.height),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configurePageControl() {
        typealias Const = Constants.PageControl
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(
                equalTo: collectionView.bottomAnchor,
                constant: Const.topMargin),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - UICollectionView Delegate
extension LifeStyleViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        // TODO: 좀 더 효율적인 방법 찾아보기
        if indexPath.row != tagTexts.count {
            selectedIndexPath = indexPath
            
            collectionView.visibleCells.forEach {
                $0.isSelected = false
            }
            
            guard let cell = collectionView.cellForItem(at: indexPath) as? LifeStyleCell else { return }
            cell.configureByIsSelected(isSelected: true)
        } else {
            if let selectedIndexPath {
                guard let cell = collectionView.cellForItem(at: selectedIndexPath) as? LifeStyleCell else { return }
                cell.configureByIsSelected(isSelected: true)
            }
        }
    }
}

// MARK: - UICollectionView Datasource
extension LifeStyleViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return tagTexts.count + 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.row == tagTexts.count {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LifeStyleDetailCell.identifier,
                for: indexPath) as? LifeStyleDetailCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LifeStyleCell.identifier,
                for: indexPath) as? LifeStyleCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            cell.setDescriptionText(text: descriptionTexts[indexPath.row])
            cell.setTitleImage(image: titleImages[indexPath.row])
            cell.setTagViews(texts: tagTexts[indexPath.row])
            cell.isSelected = indexPath == selectedIndexPath
            cell.configureByIsSelected(isSelected: cell.isSelected)
            
            return cell
        }
    }
}

// MARK: - UIScrollView Delegate
extension LifeStyleViewController {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth: CGFloat = Constants.Cell.width + Constants.CollectionView.cellSpacing
        let index = round(scrolledOffsetX / cellWidth)
        pageControl.currentPage = Int(index)
        targetContentOffset.pointee = CGPoint(
            x: index * cellWidth - scrollView.contentInset.left,
            y: scrollView.contentInset.top)
    }
}

// MARK: - LifeStyleCell Delegate
extension LifeStyleViewController: LifeStyleCellDelegate {
    func touchUpButton(cell: UICollectionViewCell) {
        if let cell = cell as? LifeStyleDetailCell {
            navigationController?.pushViewController(
                CharacterDetailSelectViewController(),
                animated: true)
        } else if let cell = cell as? LifeStyleCell {
            let viewController = LifeStylePeekViewController()
            viewController.setupContentView(
                tagTexts: cell.tagTexts,
                descriptionText: cell.descriptionText,
                image: cell.titleImage)
            navigationController?.pushViewController(
                viewController,
                animated: true)
        }
    }
}

// MARK: - QuestionContentViewDelegate
extension LifeStyleViewController: QuestionContentViewDelegate {
    func touchUpButton(sender: UIButton) {
        delegate?.touchUpSuccessButton(sender: sender)
    }
}
