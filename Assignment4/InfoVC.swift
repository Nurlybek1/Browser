//
//  InfoVC.swift
//  Assignment4
//
//  Created by Nurlybek Saktagan on 04.12.2021.
//

import UIKit
import WebKit

protocol CharactersProtocol {
    func addFavourite(name: String, webView: String)
}

class InfoVC: UIViewController {

    var webview: WKWebView!
    var url = URL(string: "https://www.google.com")
    var myProtocol: CharactersProtocol?
    var name = ""
    var contentView = UIButton()
    override func loadView() {
        webview = WKWebView()
        view = webview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myRequest = URLRequest(url: url!)
        webview.load(myRequest)
        
        contentView.frame = CGRect(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - 100, width: 60, height: 60)
        contentView.backgroundColor = .yellow
        self.view.addSubview(contentView)
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlerTapGester)))
    }
    
    @objc func handlerTapGester() {
        self.navigationController?.navigationBar.backgroundColor = .yellow
        myProtocol?.addFavourite(name: name, webView: url!.absoluteString)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView {
    func circle() -> UIImageView {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.bounds.width / 2
        
        return self
    }
}
