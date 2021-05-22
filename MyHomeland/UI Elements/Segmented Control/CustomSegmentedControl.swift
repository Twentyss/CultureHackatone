import UIKit

protocol CustomSegmentedControlDelegate: class {
    func didSelect(index: Int)
}

class CustomSegmentedControl: UIView {

    private var buttonTitles: [String]!
    
    private var buttons: [UIButton]!
    
    var selectedBackgroundColor: UIColor = .clear

    var selectedTextColor: UIColor = ColorsCollection.tintColor

    var unselectedBackgroundColor: UIColor = .clear

    var unselectedTextColor: UIColor = .gray
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    public private(set) var selectedIndex : Int = 0 {
        didSet {
            delegate?.didSelect(index: selectedIndex)
        }
    }
    public var numberOfSegments: Int {
        return buttons.count
    }
    
    convenience init(frame:CGRect, buttonTitles:[String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitles
    }

    override func layoutSubviews() {
        for button in buttons {
            button.layer.sublayers?.forEach { $0.frame = button.bounds }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
        UISetup()
    }
    
    private func UISetup() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 10
        if let sublayers = self.layer.sublayers, sublayers.count < 2 {
            let convexLayer = ConvexNeumorphismLayer(shadowType: .wide)
            convexLayer.frame = self.bounds
            self.layer.insertSublayer(convexLayer, at: 0)
        }
    }
    
    func setButtonTitles(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        self.updateView()
    }
    
    func setIndex(index:Int) {
        selectedIndex = index
        guard buttons != nil else { return }
        buttons.forEach({
            $0.setTitleColor(unselectedTextColor, for: .normal)

        })
        buttons[index].setTitleColor(selectedTextColor, for: .normal)
        buttons[index].layer.sublayers?.forEach { if $0 is ConcaveNeumorphismLayer { $0.isHidden = false } }

    }
    
    @objc func buttonAction(sender: UIButton) {
        for (index, button) in buttons.enumerated() {
            if button == sender {
                selectedIndex = index
                button.setTitleColor(selectedTextColor, for: .normal)
                button.layer.sublayers?.forEach { if $0 is ConcaveNeumorphismLayer { $0.isHidden = false } }
            } else {
                button.setTitleColor(unselectedTextColor, for: .normal)
                button.layer.sublayers?.forEach { if $0 is ConcaveNeumorphismLayer { $0.isHidden = true } }

            }
        }
    }
    
    private func updateView() {
        subviews.forEach{$0.removeFromSuperview()}
        configButtons()
        configStackView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func configButtons() {
        buttons = [UIButton]()
        buttons.removeAll()
        for title in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont(name: "SFUIText-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
            button.addTarget(self, action:#selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(unselectedTextColor, for: .normal)
            button.backgroundColor = unselectedBackgroundColor
            
            let concaveLayer = ConcaveNeumorphismLayer()
            concaveLayer.isHidden = true
            button.layer.insertSublayer(concaveLayer, at: 0)
            buttons.append(button)
        }
        buttons[selectedIndex].setTitleColor(selectedTextColor, for: .normal)
        buttons[selectedIndex].layer.sublayers?.forEach { if $0 is ConcaveNeumorphismLayer { $0.isHidden = false } }
    }
}
