//
//  PopUp.swift
//  tzpi2
//
//  Created by sova on 19. 2. 2023..
//
/*
import UIKit

class PopUp: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    

}*/
//
//  OverLayerView.swift
//  CustomPopUp
//
//  Created by Sajjad Sarkoobi on 8.07.2022.
//

import UIKit

class PopUp: UIViewController {

    var keyboardViewController:KeyboardViewController!
    //IBOutlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneButtonAction(_ sender: UIButton) {
        hide()
        
    }
    
    init() {
        super.init(nibName: "View", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
            keyboardViewController=nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        contentView.layer.borderWidth=2
        contentView.layer.borderColor=UIColor.systemBlue.cgColor
    }
    
    private func configView() {
        self.view.backgroundColor = .clear
        
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
    }
    
    func appear(sender: KeyboardViewController) {
        keyboardViewController=sender
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show() {
     //   UIView.animate(withDuration: 1, delay: 0.2) {
           self.contentView.alpha = 1
       // }
    }
    
    func hide() {
       // UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut) {
           self.contentView.alpha = 0
        //} completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        //}
    }
}
