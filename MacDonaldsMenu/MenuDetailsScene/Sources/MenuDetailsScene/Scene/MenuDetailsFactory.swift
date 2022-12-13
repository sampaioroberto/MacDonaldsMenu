import UIKit

public enum MenuDetailsFactory {
    public static func make(imageURL: URL, title: String, value: Double, description: String) -> UIViewController {
        return MenuDetailsViewController(imageURL: imageURL, title: title, value: value, description: description)
    }
}
