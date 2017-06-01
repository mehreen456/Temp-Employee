//
//  UIViewController.swift
//  Temp Provide
//
//  Created by kashif Saeed on 17/05/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import UIKit



protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}



extension UIStoryboard {
    
    /// The uniform place where we state all the storyboard we have in our application
    
    enum Storyboard: String {
        case main
        case showCase
        case registration
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    
    // MARK: - Convenience Initializers
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    
    // MARK: - Class Functions
    
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
    
    // MARK: - View Controller Instantiation from Generics
    
    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}
