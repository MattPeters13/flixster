//
//  MovieDetailsViewController.swift
//  flixster
//
//  Created by Matthew Peters on 9/28/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backDropImageView: UIImageView!
    var movie: [String:Any]!
    
    @IBOutlet weak var posterView: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(movie["title"])
        
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        let baseurl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        
        let posterUrl = URL(string: baseurl + posterPath)
        
        posterView.af.setImage(withURL: posterUrl!)
        
        let HDbaseurl = "https://image.tmdb.org/t/p/w780"
        
        let backDropPath = movie["backdrop_path"] as! String
        
        let backDropUrl = URL(string: HDbaseurl + backDropPath)
        
        backDropImageView.af.setImage(withURL: backDropUrl!)


        
        // Do any additional setup after loading the view.
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
