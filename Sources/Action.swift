import UIKit

public typealias Closure = () -> Void
public typealias Animation = (UIView, @escaping Closure) -> Void

public class Action {
  let animation: Animation

  init(animation: @escaping Animation) {
    self.animation = animation
  }
}

public extension Action {
  public static func sequence(actions: [Action]) -> Action {
    func loop(view: UIView, actions: [Action], completion: @escaping Closure) {
      guard let first = actions.first else {
        completion()
        return
      }

      var removedFirstActions = actions
      _ = removedFirstActions.removeFirst()
      first.animation(view, {
        loop(view: view, actions: removedFirstActions, completion: completion)
      })
    }

    return Action(animation: { view, completion in
      loop(view: view, actions: actions, completion: completion) 
    })
  }

  public static func parallel(actions: [Action]) -> Action {
    return Action(animation: { view, completion in
      var actions = actions
      let first = actions.removeFirst()
      first.animation(view, completion)
      actions.forEach { action in
        action.animation(view, {})
      }
    })
  }
}

public extension Action {
  public static func move() -> Action {
    return Action(animation: { view, completion in
      UIView.animate(withDuration: 2, animations: {
        view.frame.origin.x += 2
      }, completion: { _ in
        completion()
      })
    })
  }

  public static func morph() -> Action {
    return Action(animation: { view, completion in
      view.transform = CGAffineTransform(translationX: 20, y: 0)
      UIView.animate(withDuration: 0.4, delay: 0,
                     usingSpringWithDamping: 0.2,
                     initialSpringVelocity: 1,
                     options: .curveEaseInOut, animations: {
                      view.transform = CGAffineTransform.identity
      }, completion: { _ in
        completion()
      })
    })
  }
}