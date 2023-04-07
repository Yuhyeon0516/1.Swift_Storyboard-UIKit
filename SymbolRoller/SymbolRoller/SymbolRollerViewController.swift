//
//  SymbolRollerViewController.swift
//  SymbolRoller
//
//  Created by 김유현 on 2022/12/22.
//

import UIKit

class SymbolRollerViewController: UIViewController {
    
    let symbols: [String] = ["sun.min", "moon", "cloud", "wind", "snowflake"]
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    // 화면을 구성할때 viewDidLoad -> viewWillAppear -> viewDidAppear
    // 순으로 호출이 된다.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
        button.tintColor = UIColor.systemPink
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        reload()
    }
    
    // TO-DO:
    // - Symbols에서, 하나를 임의로 추출한다.
    // - imageView,label 을 구성한다.
    func reload(){
        let symbol = symbols.randomElement()!
        imageView.image = UIImage(systemName: symbol)
        label.text = symbol
    }


}
