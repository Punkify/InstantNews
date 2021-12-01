//
//  ViewController.swift
//  InstantNews
//
//  Created by Developer on 30/11/21.
//

import UIKit
import SDWebImage

class NewsViewController: UIViewController {

    var parser = XMLParser()
    var newsDetail: [String] = []
    var newsFinal : [[String]] = []
    var content: String = ""
    
    @IBOutlet weak var newsTableView: UITableView!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        parseFeed()
    }
    
    func parseFeed() {
        var parser : XMLParser?
            if let path = Bundle.main.path(forResource: "news", ofType: "xml") {
                parser = XMLParser(contentsOf: URL(fileURLWithPath: path))
                parser?.delegate = self
                parser?.parse()
    }
    }
}

extension NewsViewController:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFinal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        let item = newsFinal[indexPath.row]
        cell.newsTitle.text = item[0]
        let newsImage = item[2]
        let url = URL(string: newsImage)
        cell.imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        return cell
    }
  }


extension NewsViewController:UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = newsFinal[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        vc.newsTitle = item[0]
        vc.newsPublishDate = newsFinal[1][4]
        vc.imageURL = item[2]
        vc.articleUrl = item[1]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsViewController: XMLParserDelegate {
    
    func parserDidStartDocument(_ parser: XMLParser) {
        newsFinal.removeAll()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            newsDetail.removeAll()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "title" || elementName == "link" || elementName == "image" || elementName == "guid" || elementName == "pubDate" {
            newsDetail.append(content)
        }
        else if elementName == "item" {
            newsFinal.append(newsDetail)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        content = string
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        newsTableView.reloadData()
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError .localizedDescription)
    }
}
 


