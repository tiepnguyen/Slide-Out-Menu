//
//  ContainerViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
    case BothCollapsed
    case LeftPanelExpanded
    case RightPanelExpanded
}

class ContainerViewController: UIViewController, SidePanelViewControllerDelegate, UIGestureRecognizerDelegate {
    var centerNavigationController: UINavigationController!
    var centerViewController: UIViewController!
    var menuBarButton: UIBarButtonItem!
    
    var currentState: SlideOutState = .BothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .BothCollapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    
    var leftViewController: SidePanelViewController?
    var rightViewController: SidePanelViewController?
    
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    let centerPanelExpandedOffset: CGFloat = 60
    let sidePanelExpandedOffset: CGFloat = 260
    
    /*
    override func viewDidAppear(animated: Bool) {
        let welcomeNC = UIStoryboard.mainStoryboard().instantiateViewControllerWithIdentifier("WelcomeNavigationController") as UINavigationController
        presentViewController(welcomeNC, animated: false, completion: nil)
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBarButton = UIBarButtonItem(image: UIImage(named: "tool_menu@2x.png"), style: .Bordered, target: nil, action: "buttonAction")
        
        // centerViewController = UIStoryboard.centerViewController()
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController()
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        centerNavigationController.didMoveToParentViewController(self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        
        let vc = UIStoryboard.centerViewController()!
        vc.program = "secondary view contoller"
        centerNavigationController.viewControllers = [vc]
        centerNavigationController.viewControllers.first?.navigationItem.leftBarButtonItem = menuBarButton
        
//        let welcomeVC = UIStoryboard.mainStoryboard().instantiateViewControllerWithIdentifier("WelcomeNavigationController") as UINavigationController
//        vc.presentViewController(welcomeVC, animated: true, completion: nil)
        
    }
    
    func buttonAction() {
//        println(leftViewController?.delegate)
        toggleLeftPanel()
    }
    
    func menuItemSelected(menu: String) {
        println(menu)
        
        if menu == "favorites" {
            let vc = UIStoryboard.centerViewController()!
            vc.program = "center view controller"

            centerNavigationController.viewControllers = [vc]
        } else {
            let vc = UIStoryboard.secondaryViewController()
            vc.program = "secondary view contoller"
            centerNavigationController.viewControllers = [vc]
        }
        centerNavigationController.viewControllers.first?.navigationItem.leftBarButtonItem = menuBarButton
        collapseSidePanels()
    }
    
    // MARK: CenterViewController delegate methods
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }

    func toggleRightPanel() {
        let notAlreadyExpanded = (currentState != .RightPanelExpanded)
        
        if notAlreadyExpanded {
            addRightPanelViewController()
        }
        
        animateRightPanel(shouldExpand: notAlreadyExpanded)
    }

    func collapseSidePanels() {
        switch (currentState) {
        case .RightPanelExpanded:
            toggleRightPanel()
        case .LeftPanelExpanded:
            toggleLeftPanel()
        default:
            break
        }
    }
    
    func addLeftPanelViewController() {
        if (leftViewController == nil) {
            leftViewController = UIStoryboard.leftViewController()
            leftViewController?.delegate = self
            // leftViewController!.animals = Animal.allCats()
            
            addChildSidePanelController(leftViewController!)
        }
    }

    func addRightPanelViewController() {
        if (rightViewController == nil) {
            rightViewController = UIStoryboard.rightViewController()
            // rightViewController!.animals = Animal.allDogs()
            
            addChildSidePanelController(rightViewController!)
        }
    }

    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
        // sidePanelController.delegate = self
        
        view.insertSubview(sidePanelController.view, atIndex: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
    }
    
    func animateLeftPanel(#shouldExpand: Bool) {
        if tapGestureRecognizer == nil {
            tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handerTapGesTure:")
        }
        if (shouldExpand) {
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
            currentState = .LeftPanelExpanded
            animateCenterPanelXPosition(targetPosition: sidePanelExpandedOffset)
            centerNavigationController.view.addGestureRecognizer(tapGestureRecognizer!)
        } else {
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .BothCollapsed
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController = nil;
            }
            centerNavigationController.view.removeGestureRecognizer(tapGestureRecognizer!)
        }
    }
    
    func animateRightPanel(#shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .RightPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: -CGRectGetWidth(centerNavigationController.view.frame) + centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { _ in
                self.currentState = .BothCollapsed
                
                self.rightViewController!.view.removeFromSuperview()
                self.rightViewController = nil;
            }
        }
    }
    
    func animateCenterPanelXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            centerNavigationController.view.layer.shadowOpacity = 0.4
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
    // MARK: Gesture recognizer
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        // we can determine whether the user is revealing the left or right
        // panel by looking at the velocity of the gesture
        let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)

        switch(recognizer.state) {
        case .Began:
            if (currentState == .BothCollapsed) {
                // If the user starts panning, and neither panel is visible
                // then show the correct panel based on the pan direction
                
                if (gestureIsDraggingFromLeftToRight) {
                    addLeftPanelViewController()
                    showShadowForCenterViewController(true)
                }
                // disable right panel
                /*
                else {
                    addRightPanelViewController()
                }
                */
                // showShadowForCenterViewController(true)
            }
        case .Changed:
            // If the user is already panning, translate the center view controller's
            // view by the amount that the user has panned
            // disable right panel
            if leftViewController != nil  && recognizer.view!.frame.origin.x >= 0 {
                recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
                recognizer.setTranslation(CGPointZero, inView: view)
            }
        case .Ended:
            // When the pan ends, check whether the left or right view controller is visible
            if (leftViewController != nil) {
                // animate the side panel open or closed based on whether the view has moved more or less than halfway
                let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
                animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
            }

            else if (rightViewController != nil) {
                let hasMovedGreaterThanHalfway = recognizer.view!.center.x < 0
                animateRightPanel(shouldExpand: hasMovedGreaterThanHalfway)
            }

        default:
            break
        }

    }
    
    func handerTapGesTure(recognizer: UITapGestureRecognizer) {
         animateLeftPanel(shouldExpand: false)
    }
    
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func leftViewController() -> SidePanelViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("LeftViewController") as? SidePanelViewController
    }
    
    class func rightViewController() -> SidePanelViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("RightViewController") as? SidePanelViewController
    }
    
    class func centerViewController() -> CenterTableViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("CenterViewController") as? CenterTableViewController
    }
    
    class func secondaryViewController() -> SecondaryViewController {
        return mainStoryboard().instantiateViewControllerWithIdentifier("SecondaryViewController") as SecondaryViewController
    }
}