//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation
import BrightFutures

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

    private let threadingModel: ThreadingModel
    private var context: ExecutionContext { return threadingModel() }

    init(actions: DogListActions = DogListService(), threadingModel: @escaping ThreadingModel = DefaultThreadingModel) {
        self.actions = actions
        self.threadingModel = threadingModel
    }

    func start() {
        fetchItems()
    }

    func sort(by sortBy: SortBy) {
        items.sort { (dog1, dog2) in
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
        actions.fetchImages().onComplete(context) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dogs):
                self.items = dogs
                self.delegate?.reloadData()
            case .failure(let error):
                self.delegate?.showError(message: error.displayError)
            }
        }
    }
}


