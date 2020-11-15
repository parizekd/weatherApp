//
//  IdentifierProtocol.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import Foundation
import UIKit

protocol IdentifierProtocol {
    static var identifier: String { get }
}

extension IdentifierProtocol {
    static var identifier: String {
        String(describing: Self.self)
    }
}

extension UITableView {
    func resolveCellIdentifier<T>() -> T where T: UITableViewCell, T: IdentifierProtocol {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier) as? T else {
            fatalError("No " + T.identifier +  " for tableview")
        }
        return cell
    }

    func registerCell<T>(cell: T.Type) where T: UITableViewCell, T: IdentifierProtocol {
        register(UINib(nibName: T.identifier, bundle: nil), forCellReuseIdentifier: T.identifier)
    }
}

extension UICollectionView {
    func resolveCellIdentifier<T>(indexPath: IndexPath) -> T where T: UICollectionViewCell, T: IdentifierProtocol {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("No " + T.identifier +  " for collectionview")
        }
        return cell
    }

    func registerCell<T>(cell: T.Type) where T: UICollectionViewCell, T: IdentifierProtocol {
        register(UINib(nibName: T.identifier, bundle: nil), forCellWithReuseIdentifier: T.identifier)
    }
}
