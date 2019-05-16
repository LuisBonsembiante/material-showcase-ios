//
//  SkipButtonView.swift
//  MaterialShowcase
//
//  Created by cong.nguyen on 4/12/18.
//  Copyright © 2018 Aromajoin. All rights reserved.
//

import Foundation
import Foundation
import UIKit

public class SkipButtonView: UIView {
    internal static let SKIP_BUTTON_POS_X = 0
    internal static let SKIP_BUTTON_POS_Y = 0
    internal static let SKIP_TEXT_SIZE: CGFloat = 20
    internal static let SKIP_TEXT_COLOR = UIColor.white
    internal static let SKIP_DEFAULT_TEXT = "skip"
    internal static let SKIP_BUTTON_MARGIN: CGFloat = 20
    internal static let SKIP_BUTTON_VISIBLE: Bool = false
    internal static let SKIP_BUTTON_BACKGROUND_COLOR = UIColor.red
    internal static let SKIP_BUTTON_BORDER_RADIUS: CGFloat = 2.0
    internal static let SKIP_BUTTON_PADDING_HORIZONTAL: CGFloat = 12
    internal static let SKIP_BUTTON_PADDING_VERTICAL: CGFloat = 2

    public var skipButton: UIButton!
    public var isSkipButtonVisible: Bool!
    public var skipText: String!
    public var skipTextColor: UIColor!
    public var skipTextSize: CGFloat!
    public var skipTextFont: UIFont?
    public var skipButtonBackgroundColor: UIColor!
    public var skipButtonBorderRadius: CGFloat!
    public var skipButtonMarginLeft: CGFloat!
    public var skipButtonMarginRight: CGFloat!
    public var skipButtonMarginTop: CGFloat!
    public var skipButtonMarginBottom: CGFloat!

    public weak var delegate: MaterialShowcaseDelegate?
    public var showcaseViewTag: Int!

    public init(with text: String, size: CGFloat) {
        #if swift(>=4.0)
            let skipTextBound: CGSize = text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)])
        #else
            let skipTextBound: CGSize = text.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: size)])
        #endif

        // Create frame
        let frame = CGRect(x: 0, y: 0, width: skipTextBound.width + SkipButtonView.SKIP_BUTTON_PADDING_HORIZONTAL * 2 + 4, height: skipTextBound.height + SkipButtonView.SKIP_BUTTON_PADDING_VERTICAL * 2 + 4)
        super.init(frame: frame)
        configure()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Initializes default view properties
    fileprivate func configure() {
        setDefaultProperties()
    }

    fileprivate func setDefaultProperties() {
        // Text
        skipText = SkipButtonView.SKIP_DEFAULT_TEXT
        skipTextColor = SkipButtonView.SKIP_TEXT_COLOR
        skipTextSize = SkipButtonView.SKIP_TEXT_SIZE
        isSkipButtonVisible = SkipButtonView.SKIP_BUTTON_VISIBLE
        skipButtonBackgroundColor = SkipButtonView.SKIP_BUTTON_BACKGROUND_COLOR
        skipButtonBorderRadius = SkipButtonView.SKIP_BUTTON_BORDER_RADIUS
        skipButtonMarginLeft = SkipButtonView.SKIP_BUTTON_MARGIN
        skipButtonMarginRight = SkipButtonView.SKIP_BUTTON_MARGIN
        skipButtonMarginTop = SkipButtonView.SKIP_BUTTON_MARGIN
        skipButtonMarginBottom = SkipButtonView.SKIP_BUTTON_MARGIN
    }

    /// Calculate skip button
    private func addSkipButton() {
        //Calculate size of skip text by font
        skipButton = UIButton(type: .roundedRect)
        skipButton.setTitle(skipText, for: .normal)
        skipButton.setTitleColor(skipTextColor, for: .normal)
        skipButton.titleLabel?.textColor = UIColor.white
        skipButton.titleLabel?.font = UIFont.systemFont(ofSize: skipTextSize)
        skipButton.backgroundColor = skipButtonBackgroundColor
        skipButton.layer.cornerRadius = skipButtonBorderRadius
        skipButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        skipButton.frame = CGRect(x: 0,
                                  y: 0,
                                  width: skipButton.frame.width,
                                  height: skipButton.frame.height)
        skipButton.sizeToFit()

        // Handle gesture of skip button
        skipButton.addGestureRecognizer(tapGestureRecoganizer())
        addSubview(skipButton)
    }

    /// Create TapGestureRecoganizer of skip button
    private func tapGestureRecoganizer() -> UIGestureRecognizer {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SkipButtonView.skipButtonTouchSelector))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        return tapGesture
    }

    //Trigger skip button gesture
    @objc func skipButtonTouchSelector() {
        if delegate != nil && delegate?.showCaseSkipped != nil && showcaseViewTag != nil {
            let view = self.superview?.viewWithTag(showcaseViewTag) as! MaterialShowcase
            delegate?.showCaseSkipped?(showcase: view)
        }
    }

    /// Overrides this to add subviews. They will be drawn when calling show()
    public override func layoutSubviews() {
        super.layoutSubviews()
        addSkipButton()
        skipButton.isUserInteractionEnabled = true

    }
}
