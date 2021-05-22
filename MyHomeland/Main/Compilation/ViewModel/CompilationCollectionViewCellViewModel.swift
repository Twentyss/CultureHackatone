//
//  CompilationCollectionViewCellViewModel.swift
//  MyHomeland
//
//  Created by Александр Вторников on 10.11.2020.
//

import Foundation


class CompilationCollectionViewCellViewModel {
    
    private var compilationItem: CompilationItem
    
    var name: String {
        return compilationItem.name
    }
    
    var description: String {
        return compilationItem.descrip
    }
    
    var imageURL: String {
        return compilationItem.image
    }
    
    init(compilationItem: CompilationItem) {
        self.compilationItem = compilationItem
    }
    
}