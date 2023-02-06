//
//  CategoriesViewController.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import UIKit

typealias CategoriesDataSource = UICollectionViewDiffableDataSource<CategorySection, Category>
typealias CategoriesDataSourceSnapshot = NSDiffableDataSourceSnapshot<CategorySection, Category>

final class CategoriesViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: CategoriesDataSource!
    private var interactor: (CategoriesBusinessLogic & CategoriesDataStore)?
    private var router: (CategoriesRoutingLogic & CategoriesDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = CategoriesInteractor()
        let presenter = CategoriesPresenter()
        let router = CategoriesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchBooksCategories()
    }
        
    private func fetchBooksCategories() {
        interactor?.fetchCategories()
    }
    
    private func setupView() {
        setupTitle()
        setupSearchBar()
        setupCollectionView()
        createDataSource()
    }
    
    private func setupTitle() {
        let title = "Categories"
        self.title = title
    }
    
    private func setupSearchBar() {
        navigationController?.navigationBar.barTintColor = .mainWhite()
        navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .mainWhite()
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseID)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseID)
        collectionView.delegate = self
    }
}

// MARK: - Display Logic
extension CategoriesViewController: CategoriesDisplayLogic {
    func displayCategories(viewModel: CategoriesViewModel) {
        reloadDataSource(with: viewModel)
    }
    
    func displayAlert(with title: String, message: String) {
        self.showAlert(with: title, message: message)
    }
}

// MARK: - Collection View Delegate
extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let categoryItem = self.dataSource?.itemIdentifier(for: indexPath) else { return }
        router?.routeToBookViewController(forCategoryItem: categoryItem, itemAt: indexPath)
    }
}

// MARK: - Data Source
extension CategoriesViewController {
    private func createDataSource() {
        dataSource = CategoriesDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, category) -> UICollectionViewCell? in
            return self.configure(collectionView: collectionView, cellType: CategoryCollectionViewCell.self, with: category, for: indexPath)
        })
        
        createHeaderDataSource()
    }
    
    private func createHeaderDataSource() {
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseID, for: indexPath) as? SectionHeader else {
                let errorMessage = "Cannot create new section header"
                fatalError(errorMessage)
            }
            
            guard let section = CategorySection(rawValue: indexPath.section) else {
                let errorMessage = "Unknown section type"
                fatalError(errorMessage)
            }
            
            let items = self.dataSource.snapshot().itemIdentifiers(inSection: section)
            sectionHeader.configure(text: section.description(usersCount: items.count), font: .systemFont(ofSize: 24, weight: .light), textColor: .label)
            return sectionHeader
        }
    }
    
    private func reloadDataSource(with viewModel: CategoriesViewModel) {
        let fictionCategories = viewModel.fictionCategories
        let nonfictionCategories = viewModel.nonfictionCategories
        let childrensCategories = viewModel.childrensCategories
        
        var snapshot = CategoriesDataSourceSnapshot()
        snapshot.appendSections([.fiction, .nonfiction, .childrens])
        snapshot.appendItems(fictionCategories, toSection: .fiction)
        snapshot.appendItems(nonfictionCategories, toSection: .nonfiction)
        snapshot.appendItems(childrensCategories, toSection: .childrens)
        
        self.dataSource.apply(snapshot, animatingDifferences: true) {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Setup Compostional Layout
extension CategoriesViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            return self.createCategoriesSection()
        }
        return layout
    }
    
    private func createCategoriesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20)
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return sectionHeader
    }
}

// MARK: - Search Bar Delegate
extension CategoriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor?.filterCategories(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        interactor?.getCategories()
    }
}
