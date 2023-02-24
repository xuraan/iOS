//
//  PageView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-23.
//

import SwiftUI

import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    @Binding var currentPage: Int
    var isReversed: Bool = false

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        
        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        if currentPage < context.coordinator.controllers.count {
            pageViewController.setViewControllers(
                [context.coordinator.controllers[currentPage]], direction: .forward, animated: false)
        }
        
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        var controllers = [UIViewController]()

        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
            controllers.forEach {
                    $0.view.backgroundColor = .clear
                }
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if parent.isReversed {
                if index + 2 == controllers.count || index + 1 == controllers.count {
                    return controllers[1]
                }
                return controllers[index + 1]
            } else {
                if index == 1 || index == 0 {
                    return controllers[controllers.count-2]
                }
                return controllers[index - 1]
            }
            
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if parent.isReversed{
                if index == 1 || index == 0 {
                    return controllers[controllers.count-2]
                }
                return controllers[index - 1]
            } else {
                if index + 2 == controllers.count || index + 1 == controllers.count {
                    return controllers[1]
                }
                return controllers[index + 1]
            }
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
    }
}
