//
//  ViewController.swift
//  flixster
//
//  Created by Matthew Peters on 9/8/22.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellTableViewCell") as! MovieCellTableViewCell
//        cell.textLabel?.text = "row: \(indexPath.row)"
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let sysnopsis = movie["overview"] as! String
        //cell.textLabel!.text = title
        cell.titleLabel.text = title
        cell.sysnopsisLabel.text = sysnopsis
        
        let baseurl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        
        let posterUrl = URL(string: baseurl + posterPath)
        
        cell.posterView.af.setImage(withURL: posterUrl!)
        
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=d84c0fd35fb49e5470cf28273617635b")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 self.movies = dataDictionary["results"] as! [[String:Any]]
                 self.tableView.reloadData()
                 print(dataDictionary)

                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("Loading up the details screen")
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for:cell)!
        let movie = movies[indexPath.row]
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

