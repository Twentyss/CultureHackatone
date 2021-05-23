extension Place {
    
    struct DetailInfo {
        
        var favoritesCount: Int
        
        var viewsCount: Int
        
        var description: String
        
        var history: String
        
        var additionalInfo: String
        
        func toDictionary() -> [String: Any] {
            [ "countFavor": self.favoritesCount, "countViews": self.viewsCount, "extra": self.additionalInfo, "history": self.history, "info": self.description ]
        }
        
    }
    
}
