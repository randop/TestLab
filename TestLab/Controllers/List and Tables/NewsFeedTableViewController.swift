//
//  NewsFeedTableViewController.swift
//  TestLab
//
//  Created by Randolph on 6/18/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

import UIKit

class NewsFeedTableViewController: UITableViewController {
    
    let feed = [
        NewsFeedItem(title: "What if AI developed a 'soul'?",
                     url: "http://www.bbc.com/future/story/20180615-can-artificial-intelligence-have-a-soul-and-religion",
                     image: "http://ichef.bbci.co.uk/wwfeatures/wm/live/1600_640/images/live/p0/6b/6y/p06b6ypg.jpg",
                     body: "Then the Lord God formed man of dust from the ground, and breathed into his nostrils the breath of life; and man became a living being."),
        NewsFeedItem(title: "Fallout 76 - beta, E3 gameplay trailer, release date, online features, setting and everything we know",
                     url: "https://www.eurogamer.net/articles/2018-06-17-fallout-76-everything-we-know-5076",
                     image: "https://cdn.gamer-network.net/2018/articles/2018-06-11-04-29/fallout_76_beta.JPG",
                     body: "Fallout 76, the latest game from Fallout 4 and Skyrim developer Bethesda Game Studios, is coming some time soon, and along with news of a Fallout 76 beta we also picked up a variety of little bits of info from Bethesda's E3 conference."),
        NewsFeedItem(title: "8th Gen Intel Core",
                     url: "https://newsroom.intel.com/press-kits/8th-gen-intel-core/",
                     image: "https://simplecore.intel.com/newsroom/wp-content/uploads/sites/11/2017/08/core-8th-gen-4x1.jpg",
                     body: "The 8th Gen Intel® Core™ processor family, the newest generation of processors, is designed for what’s coming next. Experience exceptional performance, immersive entertainment and simple convenience with 8th Gen Intel Core processors. The first processors available are the mobile processors for thin and light laptops and 2 in 1s. Starting October 5, the desktop processors will be available to purchase."),
        NewsFeedItem(title: "Microsoft acquires Github",
                     url: "https://blogs.microsoft.com/blog/2018/06/04/microsoft-github-empowering-developers/",
                     image: "http://cdn1.alphr.com/sites/alphr/files/styles/simple_msn_feed/public/2018/06/40890924-4bad5ce0-6732-11e8-9648-192aa71f0830.png?itok=kwKMkFfY",
                     body: "Today, we announced an agreement to acquire GitHub, the world’s leading software development platform. I want to share what this acquisition will mean for our industry and for developers. The era of the intelligent cloud and intelligent edge is upon us. Computing is becoming embedded in the world, with every part of our daily life and work and every aspect of our society and economy being transformed by digital technology. Developers are the builders of this new era, writing the world’s code. And GitHub is their home.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableCell", for: indexPath)
        cell.textLabel?.text = feed[indexPath.row].title
        cell.detailTextLabel?.text = feed[indexPath.row].body
        let rectDimension:CGFloat = 96
        
        let imageUrl:URL = URL(string: feed[indexPath.row].image)!
        DispatchQueue.global(qos: .userInteractive).async {
            let imageData = try? Data(contentsOf: imageUrl)
            if let imageData = imageData {
                let image = UIImage(data: imageData)
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: rectDimension, height: rectDimension))
                imageView.contentMode = .scaleAspectFit
                imageView.image = image
                imageView.tag = 0
                
                DispatchQueue.main.async {
                    cell.addSubview(imageView)
                    cell.indentationWidth = rectDimension
                    cell.indentationLevel = 1
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewnewsfeed", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewnewsfeed" {
            let indexPath = sender as! IndexPath
            let newsItem = feed[indexPath.row]
            let viewController = segue.destination as? NewsViewController
            viewController?.url = URL(string: newsItem.url)
        }
    }
}
