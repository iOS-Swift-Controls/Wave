//
//  ViewSpringChain.swift
//  Wave
//
//  Created by Khoa Pham on 27/05/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import UIKit

public extension View {

  public final class SpringChain: Chainable {
    
    public var actions: [Action] = []
    public let view: UIView

    public init(view: UIView) {
      self.view = view
    }

  }
}

// MARK: - Configure

public extension View.SpringChain {

  public func duration(interval: NSTimeInterval) -> View.SpringChain {
    return configure { (inout action: View.SpringAction) in
      action.duration = interval
    }
  }

  public func delay(interval: NSTimeInterval) -> View.SpringChain {
    return configure { (inout action: View.SpringAction) in
      action.delay = interval
    }
  }

  public func option(options: UIViewAnimationOptions) -> View.SpringChain {
    return configure { (inout action: View.SpringAction) in
      action.options = options
    }
  }

  public func damping(value: CGFloat) -> View.SpringChain {
    return configure { (inout action: View.SpringAction) in
      action.damping = value
    }
  }

  public func velocity(value: CGFloat) -> View.SpringChain {
    return configure { (inout action: View.SpringAction) in
      action.velocity = value
    }
  }

  public func replay(number: UInt) -> View.SpringChain {
    return configure { (inout action: View.SpringAction) in
      action.replay = number
    }
  }
}

// MARK: - Animate

extension View.SpringChain: ViewAnimatable {

  public func animate(block: Block) -> View.SpringChain {
    var action = View.SpringAction()
    action.block = block

    return link(action)
  }
}
