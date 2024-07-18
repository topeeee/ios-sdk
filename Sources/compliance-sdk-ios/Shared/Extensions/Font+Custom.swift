
import UIKit

public enum ComplianceSDKFont: String, CaseIterable {
    case moderatRegular = "Moderat-Regular"
    case moderatMedium = "Moderat-Medium"
    case moderateLight = "Moderat-Light"
    case moderateBold = "Moderat-Bold"
    case garnettRegular = "Garnett-Regular"
    case garnettMedium = "Garnett-Medium"
    case garnettLight = "Garnett-Light"
    case garnettBold = "Garnett-Bold"
    case malik = "Millik"
}

public extension UIFont {
    public static func custom(_ font: ComplianceSDKFont, size: CGFloat) -> UIFont {
        UIFont(name: font.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
    
}
