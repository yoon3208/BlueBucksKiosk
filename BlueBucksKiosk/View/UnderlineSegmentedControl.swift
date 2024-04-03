//
//  UnderlineSegmentedControl.swift
//  BlueBucksKiosk
//
//  Created by 김정호 on 4/3/24.
//

import UIKit

final class UnderlineSegmentedControl: UISegmentedControl {
    
    // MARK: - properties
    private lazy var underlineView: UIView = {
        let width = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let height = 2.0
        let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
        let yPosition = self.bounds.size.height - 6.0
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        let view = UIView(frame: frame)
        view.backgroundColor = .init(red: 0, green: 168/255, blue: 217/255, alpha: 1)
        self.addSubview(view)
        return view
    }()
    
    // MARK: - life cycles
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(self.selectedSegmentIndex)
        
        UIView.animate(
            withDuration: 0.2,
            animations: { self.underlineView.frame.origin.x = underlineFinalXPosition }
        )
    }
    
    // MARK: - methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.removeBackgroundAndDivider()
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        self.removeBackgroundAndDivider()
        
        self.selectedSegmentIndex = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func removeBackgroundAndDivider() {
        let image = UIImage()
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
}
