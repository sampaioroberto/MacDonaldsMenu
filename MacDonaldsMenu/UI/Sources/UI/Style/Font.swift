import UIKit

extension UIFont {
    public static func small(weight: Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 14)
    }

    public static func medium(weight: Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 16, weight: weight)
    }

    public static func big(weight: Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 24, weight: weight)
    }

    public static func veryBig(weight: Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 28, weight: weight)
    }
}
