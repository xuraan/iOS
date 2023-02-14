//
//  PageView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct PageView<Page: View>: UIViewControllerRepresentable {
    @Binding var selection: Int
    var isReversed: Bool = false
    var pages: [Page]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageView = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        pageView.dataSource = context.coordinator
        pageView.delegate = context.coordinator
        
        return pageView
    }

    func updateUIViewController(_ pageView: UIPageViewController, context: Context) {
        if selection < context.coordinator.controllers.count {
            pageView.setViewControllers(
                [context.coordinator.controllers[selection]], direction: .forward, animated: false)
        }
        
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageView
        var controllers = [UIViewController]()

        init(_ pageView: PageView) {
            parent = pageView
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
            controllers.forEach {
                    $0.view.backgroundColor = .clear
                }
        }

        func pageViewController(
            _ pageView: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if parent.isReversed {
                if index + 1 == controllers.count {
                    return controllers.first
                }
                return controllers[index + 1]
            } else {
                if index == 0 {
                    return controllers.last
                }
                return controllers[index - 1]
            }
            
        }

        func pageViewController(
            _ pageView: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if parent.isReversed{
                if index == 0 {
                    return controllers.last
                }
                return controllers[index - 1]
            } else {
                if index + 1 == controllers.count {
                    return controllers.first
                }
                return controllers[index + 1]
            }
        }

        func pageViewController(
            _ pageView: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool) {
            if completed,
               let visibleViewController = pageView.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.selection = index
            }
        }
    }
}
