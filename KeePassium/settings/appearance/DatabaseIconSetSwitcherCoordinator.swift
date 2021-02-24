//  KeePassium Password Manager
//  Copyright © 2018–2021 Andrei Popleteev <info@keepassium.com>
//
//  This program is free software: you can redistribute it and/or modify it
//  under the terms of the GNU General Public License version 3 as published
//  by the Free Software Foundation: https://www.gnu.org/licenses/).
//  For commercial licensing, please contact the author.

import KeePassiumLib

class DatabaseIconSetSwitcherCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    typealias DismissHandler = (DatabaseIconSetSwitcherCoordinator) -> Void
    var dismissHandler: DismissHandler?
    
    private let router: NavigationRouter
    private let picker: DatabaseIconSetPicker
    
    init(router: NavigationRouter) {
        self.router = router
        picker = DatabaseIconSetPicker.instantiateFromStoryboard()
        picker.delegate = self
    }
    
    func start() {
        picker.selectedItem = Settings.current.databaseIconSet
        router.push(picker, animated: true, onPop: { [self] (viewController) in 
            self.dismissHandler?(self)
        })
    }
}


extension DatabaseIconSetSwitcherCoordinator: DatabaseIconSetPickerDelegate {
    func didSelect(iconSet: DatabaseIconSet, in picker: DatabaseIconSetPicker) {
        Settings.current.databaseIconSet = iconSet
        router.pop(animated: true)
    }
}