//
//  MovieDetailsViewController.swift
//  omdbapi-test
//
//  Created by Joel Sene on 06/04/17.
//  Copyright © 2017 Rafael Meyer. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var segueData:String!
    var imageMovieDetailsUrl:String!
    var nameMovieDetails:String!
    var plotMovieDetails:String!

    var delegateMovieDetails : ViewController?
    
    @IBOutlet weak var movieDetailsImageView: UIImageView!
    @IBOutlet weak var titleMovieDetailsTextView: UILabel!
    @IBOutlet weak var plotMovieDetailsTextView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadMovieDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func loadMovieDetails() {
        let movieName = segueData.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
        let urlApi = "http://www.omdbapi.com/?t="+movieName
        print(urlApi)
        let url = URL(string: urlApi)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil
            {
                print("error")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        //Resultado da busca do JSON
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary
                        
                        if let poster = myJson["Poster"] {
                            self.imageMovieDetailsUrl = String(describing: poster)
                        }
                        if let title = myJson["Title"] {
                            self.nameMovieDetails = String(describing: title)
                        }
                        if let plot = myJson["Plot"] {
                            self.plotMovieDetails = String(describing: plot)
                        }

                        let imageUrl = self.imageMovieDetailsUrl
                        let url = URL(string: imageUrl!)
                        let data = try? Data(contentsOf: url!)

                        self.movieDetailsImageView.image = UIImage(data: data!)
                        self.titleMovieDetailsTextView.text = self.nameMovieDetails
                        self.plotMovieDetailsTextView.text = self.plotMovieDetails
                    }
                    catch
                    {
                        print("error in JSONSerialization")
                    }
                }
            }
        }
        task.resume()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
