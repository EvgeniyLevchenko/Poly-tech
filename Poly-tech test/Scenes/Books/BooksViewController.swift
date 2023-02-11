//
//  BooksViewController.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import UIKit

typealias BooksDataSource = UICollectionViewDiffableDataSource<CategorySection, Book>
typealias BooksDataSourceSnapshot = NSDiffableDataSourceSnapshot<CategorySection, Book>

final class BooksViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: BooksDataSource!
    var interactor: (BooksBusinessLogic & BooksDataStore)?
    var router: (BooksRoutingLogic & BooksDataPassing)?
    
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
        let interactor = BooksInteractor()
        let presenter = BooksPresenter()
        let router = BooksRouter()
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
        getBooks()
    }
    
    func getBooks() {
        interactor?.getBooks()
    }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    private func setupView() {
        setupSearchBar()
        setupCollectionView()
        createDataSource()
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
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.reuseID)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseID)
    }
}

// MARK: Books Display Logic
extension BooksViewController: BooksDisplayLogic {
    func displayBooks(viewModel: BooksViewModel) {
        DispatchQueue.main.async {
            self.reloadDataSource(with: viewModel)
            guard let title = viewModel.title else { return }
            self.setTitle(title: title)
        }
    }
    
    func displayAlert(with title: String, message: String) {
        showAlert(with: title, message: message)
    }
}

// MARK: - Data source
extension BooksViewController {
    private func createDataSource() {
        dataSource = BooksDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, book) -> UICollectionViewCell? in
            let cell = self.configure(collectionView: collectionView, cellType: BookCollectionViewCell.self, with: book, for: indexPath)
            cell.delegate = self
            return cell
        })
    }
    
    private func reloadDataSource(with viewModel: BooksViewModel) {
        var snapshot = BooksDataSourceSnapshot()
        let books = viewModel.books
        snapshot.appendSections([.unspecified])
        snapshot.appendItems(books, toSection: .unspecified)
        self.dataSource.apply(snapshot, animatingDifferences: true) {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Setup Compostional Layout
extension BooksViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            return self.createBooksSection()
        }
        return layout
    }
    
    private func createBooksSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(350))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20)
        return section
    }
}

// MARK: - Search Bar Delegate
extension BooksViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor?.filterBooks(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        interactor?.getBooks()
    }
}

// MARK: - Router delegate
extension BooksViewController: RouterDelegate {
    func routeToWebView(with url: String) {
        router?.routeToWebViewController(with: url)
    }
}
