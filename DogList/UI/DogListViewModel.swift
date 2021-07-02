//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation

protocol DogListViewModelDelegate: AnyObject, ShowsError {
    func reloadData()
}

class DogListViewModel {
    enum SortBy: CaseIterable {
        case ascending
        case descending

        var title: String {
            switch self {
            case .ascending: return NSLocalizedString("Ascending", comment: "")
            case .descending: return NSLocalizedString("Descending", comment: "")
            }
        }
    }

    let title = NSLocalizedString("DogsList", comment: "")
    let sortActionTitle = NSLocalizedString("Sort", comment: "")
    let sortActionDescription = NSLocalizedString("Sort by life span", comment: "")

    private(set) var items: [Dog] = []

    private let actions: DogListActions
    weak var delegate: DogListViewModelDelegate?

    init(actions: DogListActions = DogListService()) {
        self.actions = actions
    }

    func start() {
        fetchItems()
    }

    func sort(by sortBy: SortBy) {
        items.sort { dog1, dog2 in
            let lifespan1 = dog1.lifeSpan ?? Dog.LifeSpanYear.constant(0)
            let lifespan2 = dog2.lifeSpan ?? Dog.LifeSpanYear.constant(0)
            switch sortBy {
            case .ascending:
                return lifespan1 < lifespan2
            case .descending:
                return lifespan1 > lifespan2
            }
        }
        delegate?.reloadData()
    }

    private func fetchItems() {
        actions.fetchImages() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(dogs):
                self.items = dogs
                self.delegate?.reloadData()
            case let .failure(error):
                self.delegate?.showError(message: error.displayError)
            }
        }
    }
}
