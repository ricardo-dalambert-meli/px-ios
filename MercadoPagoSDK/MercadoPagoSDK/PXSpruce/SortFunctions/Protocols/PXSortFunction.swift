import UIKit

/// An internal struct that is used to relate a view with a time offset. This is used to determine when each view is set to animate.
internal struct TimedView {

    /// the view that is to be animated
    let spruceView: View

    /// the offset of this view animating from the start of the overall animation
    var timeOffset: TimeInterval
}

/// For all the views on the screen, we need to find some way of organizing them so that when we start the animation, each view will know when to start their individual animation. The concept of a `SortFunction` is just that. Given a view, the subviews of that view are sorted in a way that when animated they resemble the nature of that sort function. There are many different types of sort functions because there are so many ways to sort the subviews that are on the screen. If you don't see a stock one that fits your need, feel free to implement this protocol and use your own custom `SortFunction` with Spruce.
internal protocol SortFunction {

    /// Given a view, view sort the subviews in a way that matches the desired specification of the `SortFunction`. In an example case, if you wanted a radial sort function then this method would return an array of the subviews such that their time offets would be smaller near the center of the view and grow as they get further from the center point.
    /// - Note: This method simply calls the `timeOffsets(view: UIView, recursiveDepth: Int)` with a `recursiveDepth` of `0`.
    ///
    /// - Parameter view: the view whose subviews should be animated. This view should not be included in the returned array
    /// - Returns: an array of `TimedView`'s which contain references to the view needed to be animated and the time offset for when the animation of that individual view should start relative to the start of the overall animation
    func timeOffsets(view: UIView) -> [TimedView]

    /// Given a view, view sort the subviews in a way that matches the desired specification of the `SortFunction`. In an example case, if you wanted a radial sort function then this method would return an array of the subviews such that their time offets would be smaller near the center of the view and grow as they get further from the center point.
    ///
    /// - Parameters:
    ///   - view: the view whose subviews should be animated. This view should not be included in the returned array
    ///   - recursiveDepth: an int describing how deep into the view hiearchy the subview search should go, defaults to 0. A value of 0 is the same as calling the `subviews` on the actual view itself. Therefore a depth of 1 will be getting the subviews of each of the subviews, etc...
    /// - Returns: an array of `TimedView`'s which contain references to the view needed to be animated and the time offset for when the animation of that individual view should start relative to the start of the overall animation
    func timeOffsets(view: UIView, recursiveDepth: Int) -> [TimedView]
}

internal extension SortFunction {
    func timeOffsets(view: UIView) -> [TimedView] {
        return timeOffsets(view: view, recursiveDepth: 0)
    }
}
