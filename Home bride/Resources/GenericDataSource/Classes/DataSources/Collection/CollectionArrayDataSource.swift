//
//  CollectionArrayDataSource.swift
//  GenericDataSource
//
//  Created by Andrea Prearo on 4/20/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import UIKit

open class CollectionArrayDataSource<T, Cell: UICollectionViewCell>: CollectionDataSource<ArrayDataProvider<T>, Cell>
    where Cell: ConfigurableCell, Cell.T == T
{
    // MARK: - Lifecycle
    public convenience init(collectionView: UICollectionView, array: [T], itemSize: CGSize) {
        self.init(collectionView: collectionView, array: [array], itemSize: itemSize)
    }

    public init(collectionView: UICollectionView, array: [[T]], itemSize: CGSize) {
        let provider = ArrayDataProvider(array: array)
        super.init(collectionView: collectionView, provider: provider, itemSize: itemSize)
    }

    // MARK: - Public Methods
    public func item(at indexPath: IndexPath) -> T? {
        return provider.item(at: indexPath)
    }

    public func updateItem(at indexPath: IndexPath, value: T) {
        provider.updateItem(at: indexPath, value: value)
    }
}
