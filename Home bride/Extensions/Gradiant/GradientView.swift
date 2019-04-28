
import UIKit

final class LinearGradientLayer: CALayer {
    enum Direction {
        case vertical
        case horizontal
        case topToBottom
        case bottomToTop
        case leftToRight
        case rightToLeft
        case topLeftToBottomRight
        case topRightToBottomLeft
        case bottomLeftToTopRight
        case bottomRightToTopLeft
        case custom(start: CGPoint, end: CGPoint)
        var points: (start: CGPoint, end: CGPoint) {
            switch self {
            case .vertical:
                return (CGPoint(x: 0.5, y: 0.0), CGPoint(x: 0.5, y: 1.0))
            case .horizontal:
                return (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5))
            case .topToBottom:
                return (CGPoint(x: 0.5, y: 0.0), CGPoint(x: 0.5, y: 1.0))
            case .bottomToTop:
                return (CGPoint(x: 0.5, y: 1.0), CGPoint(x: 0.5, y: 0.0))
            case .leftToRight:
                return (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5))
            case .rightToLeft:
                return (CGPoint(x: 1.0, y: 0.5), CGPoint(x: 0.0, y: 0.5))
            case .topLeftToBottomRight:
                return (CGPoint.zero, CGPoint(x: 1.0, y: 1.0))
            case .topRightToBottomLeft:
                return (CGPoint(x: 1.0, y: 0.0), CGPoint(x: 0.0, y: 1.0))
            case .bottomLeftToTopRight:
                return (CGPoint(x: 0.0, y: 1.0), CGPoint(x: 1.0, y: 0.0))
            case .bottomRightToTopLeft:
                return (CGPoint(x: 1.0, y: 1.0), CGPoint(x: 0.0, y: 0.0))
            case let .custom(start, end):
                return (start, end)
            }
        }
    }
    
    var direction: Direction = .vertical
    var colorSpace = CGColorSpaceCreateDeviceRGB()
    var colors: [CGColor]?
    var locations: [CGFloat]?
    var options: CGGradientDrawingOptions = CGGradientDrawingOptions(rawValue: 0)
    required override init() {
        super.init()
        masksToBounds = true
        needsDisplayOnBoundsChange = true
    }
    
    init(colors: [UIColor]) {
        super.init()
        masksToBounds = true
        needsDisplayOnBoundsChange = true
        var myColors = [CGColor]()
        colors.forEach { (color) in
            myColors.append(color.cgColor)
        }
        self.colors = myColors
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    required override init(layer: Any) {
        super.init(layer: layer)
    }
    override func draw(in ctx: CGContext) {
        ctx.saveGState()
        guard let colors = colors, let gradient = CGGradient(colorsSpace: colorSpace,
                                                             colors: colors as CFArray, locations: locations) else { return }
        let points = direction.points
        ctx.drawLinearGradient(
            gradient,
            start: transform(points.start),
            end: transform(points.end),
            options: options
        )
    }
    private func transform(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: bounds.width * point.x, y: bounds.height * point.y)
    }
}
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
//        gradientLayer.locations = [0.0, 0.5, 0.1]
//        gradientLayer.frame = viewToAddGradiant.frame
//        viewToAddGradiant.layer.mask = gradientLayer
