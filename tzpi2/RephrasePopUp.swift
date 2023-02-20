
import UIKit

class RephrasePopUp: UIViewController {

    var keyboardViewController:KeyboardViewController!
    //IBOutlets
    @IBOutlet weak var contentView: UIView!
   
    
    @IBAction func humoristic(_ sender: Any) {
        keyboardViewController.rephraseCallback(option: "humoristic")
        hide()
    }
    @IBAction func sympathetic(_ sender: Any) {
        keyboardViewController.rephraseCallback(option: "sympathetic")
        hide()
    }
    @IBAction func sincere(_ sender: Any) {
        keyboardViewController.rephraseCallback(option: "sincere")
        hide()
    }
    @IBAction func friendly(_ sender: Any) {
        keyboardViewController.rephraseCallback(option: "friendly")
        hide()
    }
    @IBAction func caring(_ sender: Any) {
        keyboardViewController.rephraseCallback(option: "caring")
        hide()
    }
    @IBAction func formal(_ sender: Any) {
        keyboardViewController.rephraseCallback(option: "formal")
        hide()
    }
    @IBAction func excited(_ sender: Any) {
        keyboardViewController.rephraseCallback(option: "excited")
        hide()
    }
    @IBAction func sarcastic(_ sender: Any) {
        keyboardViewController.rephraseCallback(option: "sarcastic")
        hide()
    }
    init() {
        super.init(nibName: "RephrasePopUp", bundle: nil)
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
        contentView.layer.borderColor=UIColor.blue.cgColor
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
        UIView.animate(withDuration: 1, delay: 0.2) {
           self.contentView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut) {
           self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
}
