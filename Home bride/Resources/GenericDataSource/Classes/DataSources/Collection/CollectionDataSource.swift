//
//  CollectionDataSource.swift
//  GenericDataSource
//
//  Created by Andrea Prearo on 4/20/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import UIKit

public typealias CollectionItemSelectionHandlerType = (IndexPath) -> Void

open class CollectionDataSource<Provider: CollectionDataProvider, Cell: UICollectionViewCell>:
    NSObject,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
    where Cell: ConfigurableCell, Provider.T == Cell.T
{
    // MARK: - Delegates
    public var collectionItemSelectionHandler: CollectionItemSelectionHandlerType?

    // MARK: - Private Properties
    let provider: Provider
    let collectionView: UICollectionView
    let itemSize: CGSize
    
    // MARK: - Lifecycle
    init(collectionView: UICollectionView, provider: Provider, itemSize: CGSize) {
        self.collectionView = collectionView
        self.itemSize = itemSize
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        self.provider = provider
        super.init()
        setUp()
    }

    func setUp() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    // MARK: - UICollectionViewDataSource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return provider.numberOfSections()
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return provider.numberOfItems(in: section)
    }

    open func collectionView(_ collectionView: UICollectionView,
         cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier,
            for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        let item = provider.item(at: indexPath)
        if let item = item {
            cell.configure(item, at: indexPath)
        }
        return cell
    }

    open func collectionView(_ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView
    {
        return UICollectionReusableView(frame: CGRect.zero)
    }

    // MARK: - UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionItemSelectionHandler?(indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
}
