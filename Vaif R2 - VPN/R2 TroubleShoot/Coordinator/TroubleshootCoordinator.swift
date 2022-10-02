//
//  TroubleshootCoordinator.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/27/22.
//

import Foundation


protocol TroubleshootCoordinatorFactory {
    func makeTroubleshootCoordinator() -> TroubleshootCoordinator
}

extension DependencyContainer: TroubleshootCoordinatorFactory {
    func makeTroubleshootCoordinator() -> TroubleshootCoordinator {
        return TroubleshootCoordinatorImplementation(self)
    }
}

protocol TroubleshootCoordinator: Coordinator {
}

class TroubleshootCoordinatorImplementation: TroubleshootCoordinator {
    
    typealias Factory = WindowServiceFactory & TroubleshootViewModelFactory
    private let factory: Factory
    
    private lazy var windowService: WindowService = factory.makeWindowService()
    
    public init(_ factory: Factory) {
        self.factory = factory
    }
    
    func start() {
        let troubleshootViewModel: TroubleshootViewModel = factory.makeTroubleshootViewModel()
        troubleshootViewModel.cancelled = {
            // *Strong* self, but as view model is released together with a view controller, this object is released too.
            // Has to be strong, because this coordinator is started from iOSAlertService which does not retain it.
            self.windowService.dismissModal { }
        }
        let controller = TroubleshootViewController(troubleshootViewModel)
        windowService.present(modal: controller)
    }
    
}
