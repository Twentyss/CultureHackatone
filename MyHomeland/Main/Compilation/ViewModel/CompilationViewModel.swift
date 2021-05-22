import Foundation

class CompilationViewModel {
    
    private var selectedIndexPath: IndexPath?
    
    var compilationItems: [CompilationItem] = []
    
    func getCompilation(completion: @escaping ()->()) {
        AppDatabase.shared.observe { (items) in
            if let items = items {
                self.compilationItems = items.sorted { $0.id < $1.id }
                completion()
            }
        }
    }
    
    func numberOfRow() -> Int {
        return compilationItems.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CompilationCollectionViewCellViewModel? {
        let compilationItem = compilationItems[indexPath.row]
        return CompilationCollectionViewCellViewModel(compilationItem: compilationItem)
    }
    
    func viewModelForSelectedRow(atIndexPath indexPath: IndexPath) -> CompilationDetailViewModel? {
        return CompilationDetailViewModel(compilationItem: compilationItems[indexPath.row])
    }
    
}
