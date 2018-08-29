//
//  ScaledFont.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/23.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit

/// A utility class to help you use custom fonts with
/// dynamic type.
///
/// To use this class you must supply the name of a style
/// dictionary for the font when creating the class. The
/// style dictionary should be stored as a property list
/// file in the main bundle.
///
/// The style dictionary contains an entry for each text
/// style that uses the raw string value for each
/// `UIFontTextStyle` as the key.
///
/// The value of each entry is a dictionary with two keys:
///
/// + fontName: A String which is the font name.
/// + fontSize: A number which is the point size to use
///             at the `.large` content size.
///
/// For example to use a 17 pt Noteworthy-Bold font
/// for the `.headline` style at the `.large` content size:
///
///     <dict>
///         <key>UICTFontTextStyleHeadline</key>
///         <dict>
///             <key>fontName</key>
///             <string>Noteworthy-Bold</string>
///             <key>fontSize</key>
///             <integer>17</integer>
///         </dict>
///     </dict>
///
/// You do not need to include an entry for every text style
/// but if you try to use a text style that is not included
/// in the dictionary it will fallback to the system preferred
/// font.
public final class ScaledFont {
    
    private struct FontDescription: Decodable {
        let fontSize: CGFloat
        let fontName: String
    }
    
    private typealias StyleDictionary = [UIFontTextStyle.RawValue: FontDescription]
    private var styleDictionary: StyleDictionary?
    
    /// Create a `ScaledFont`
    ///
    /// - Parameter fontName: Name of a plist file (without the extension)
    ///   in the main bundle that contains the style dictionary used to
    ///   scale fonts for each text style.
        
    public init(fontName: String? = nil) {
        if fontName != nil && fontName != "System"{
            if let url =
                Bundle.main.url(forResource: fontName, withExtension: "plist"),
                let data = try? Data(contentsOf: url) {
                let decoder = PropertyListDecoder()
                styleDictionary = try? decoder.decode(StyleDictionary.self, from: data)
            }
        }
    }
    
    /// Get the scaled font for the given text style using the
    /// style dictionary supplied at initialization.
    ///
    /// - Parameter textStyle: The `UIFontTextStyle` for the
    ///   font.
    /// - Returns: A `UIFont` of the custom font that has been
    ///   scaled for the users currently selected preferred
    ///   text size.
    ///
    /// - Note: If the style dictionary does not have
    ///   a font for this text style the default preferred
    ///   font is returned.
    public func font(forTextStyle textStyle: UIFontTextStyle) -> UIFont {
        let fontDescription = styleDictionary?[textStyle.rawValue]
        if  fontDescription != nil{
            let font = UIFont(name: fontDescription!.fontName, size: fontDescription!.fontSize)
            return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font!)
        }else{
            return UIFont.preferredFont(forTextStyle: textStyle)
        }
    }
    
}
