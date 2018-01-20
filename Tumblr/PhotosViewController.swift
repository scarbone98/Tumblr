//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Samuel Carbone on 1/12/18.
//  Copyright © 2018 Samuel Carbone. All rights reserved.
//
import UIKit
import AlamofireImage
class PhotosViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    var posts: [[String: Any]] = []
    @IBOutlet weak var photosTable: UITableView!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PhotoDetailsViewController
        let cell = sender as! UITableViewCell
        let indexPath = photosTable.indexPath(for: cell)!
        let post = posts[indexPath.section]
        vc.data = post["caption"] as! String
        vc.imageData = (self.photosTable.cellForRow(at: indexPath) as! PhotoCell).picture.image
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.7)
        let post = posts[section]
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
        profileView.layer.borderWidth = 1;
        let dateLabel = UILabel(frame: CGRect(x:145,y:0,width:400,height:50))
        let date = post["date"] as! String
        let dateArr = date.split(separator: " ")
        let myDate = String(dateArr[0])
        dateLabel.text = myDate
        // Set the avatar
        profileView.af_setImage(withURL: URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar")!)
        headerView.addSubview(profileView)
        headerView.addSubview(dateLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = posts[indexPath.section]
        if let photos = post["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            cell.picture.af_setImage(withURL: url!)
        }
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        photosTable.delegate = self
        photosTable.dataSource = self
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                self.photosTable.reloadData()
            }
        }
        task.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
