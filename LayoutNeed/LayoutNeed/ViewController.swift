//
//  ViewController.swift
//  LayoutNeed
//
//  Created by PIG on 2022/11/27.
//

import UIKit

class ViewController: UIViewController {
    
    let adjustButton = UIButton();
    let redView = UIView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView();
        constrains();
        setupUI();
        adjustButton.addTarget(self, action: #selector(myAnimate), for: .touchUpInside);
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        redView.layer.cornerRadius = redView.frame.width / 2;
    }
    
    @objc
    func myAnimate() {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
            self.redView.frame.origin.y += 100
        }, completion: nil)
    }
    
    func addSubView() {
        self.view.addSubview(adjustButton);
        self.view.addSubview(redView);
    }
    
    func constrains() {
        adjustButton.translatesAutoresizingMaskIntoConstraints = false;
        adjustButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 50, paddingBottom: 100, paddingRight: 50, width: 0, height: 50, enableInsets: false);
        
        redView.translatesAutoresizingMaskIntoConstraints = false;
        redView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 50, paddingBottom: 0, paddingRight: 0, width: 100, height: 100, enableInsets: false);
    }
    
    func setupUI() {
        adjustButton.backgroundColor = .systemBlue;
        adjustButton.setTitle("Animate", for: .normal);
        redView.backgroundColor = .systemRed;
        redView.clipsToBounds = true;

    }
    
}


extension UIView {
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
            
            print("Top: \(topInset)")
            print("bottom: \(bottomInset)")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}
