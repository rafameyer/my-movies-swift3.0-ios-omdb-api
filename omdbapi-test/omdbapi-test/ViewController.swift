//
//  ViewController.swift
//  omdbapi-test
//
//  Created by Joel Sene on 05/04/17.
//  Copyright © 2017 Rafael Meyer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var movie:Movie?
    var movies:Array<Movie>? = []
        
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        searchMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func searchMovies() {
        let url = URL(string: "http://www.omdbapi.com/?s=car")
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
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableLeaves) as AnyObject
                        //Array MultiDimensões
                        if let search = myJson["Search"] as? [NSDictionary]
                        {
                            for result in search {
                                print(result["Title"]!)
                                print(result["Type"]!)
                                print(result["Poster"]!)
                                print(result["Year"]!)
                                
                                let auxName     = result["Title"]
                                let auxType     = result["Type"]
                                let auxPoster   = result["Poster"]
                                let auxYear     = result["Year"]
                                self.movies?.append(Movie(name: auxName as! String, type: auxType as! String, year: auxYear as! String, poster: auxPoster as! String))
            
                            }
                        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueMoveDetails") {
            let view = segue.destination as! MovieDetailsViewController
            movie = movies?[tableView.indexPathForSelectedRow!.row]
            view.segueData = movie?.name
            view.delegateMovieDetails = self
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! TableViewCell
        let row = indexPath.row
        
        cell.nameMovieText.text = movies?[row].name
        cell.typeMovieText.text = movies?[row].type
        cell.yearMovieText.text = movies?[row].year
        
        let imageUrl  = movies?[row].poster
        let url = URL(string: imageUrl!)
        let data = try? Data(contentsOf: url!)
    
        cell.imageMovieText.image = UIImage(data: data!)
        
        return cell
    }


}

