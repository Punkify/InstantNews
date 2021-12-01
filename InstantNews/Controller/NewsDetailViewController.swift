//
//  NewsDetailViewController.swift
//  InstantNews
//
//  Created by Developer on 1/12/21.
//

import UIKit
import SafariServices
import SDWebImage

class NewsDetailViewController: UIViewController {
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    var newsTitle: String?
    var newsPublishDate: String?
    var imageURL: String?
    var articleUrl: String?
    
    func converStringToDate() -> Date {
        
        let publishDate = newsPublishDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:publishDate!)!
        return date
        }
        
    func publishDate() -> String {
            let date = converStringToDate()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MMM/yyyy"
            let dateToString = dateFormatter.string(from: date)
            return dateToString
        }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTitleLabel.text = newsTitle
        dateLabel.text = publishDate()
        newsImageView.sd_setImage(with: URL(string: imageURL!), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    @IBAction func viewArticlePressed(_ sender: Any) {
        
        guard let url = URL(string: articleUrl!) else {
            return print("error")
        }
        
               let config = SFSafariViewController.Configuration()
               config.entersReaderIfAvailable = true

               let vc = SFSafariViewController(url: url, configuration: config)
               present(vc, animated: true)
           
    }
    
}
