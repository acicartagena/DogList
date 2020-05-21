//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation
import BrightFutures

protocol DogListViewModelDelegate: AnyObject {
    func reloadData()
}

class DogListViewModel {

    private(set) var items: [Dog] = []
    private let actions: DogListActions
    weak var delegate: DogListViewModelDelegate?

    private let threadingModel: ThreadingModel
    private var context: ExecutionContext { return threadingModel() }

    init(actions: DogListActions = DogListService(), threadingModel: @escaping ThreadingModel = DefaultThreadingModel) {
        self.actions = actions
        self.threadingModel = threadingModel
        fetchItems()
    }

    func fetchItems() {
        actions.fetchImages().onComplete(context) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dogs):
                self.items = dogs
                self.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}


