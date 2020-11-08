//
//  ViewController.swift
//  MovieBuzz
//
//  Created by GOQii-Subhojit on 06/11/20.
//  Copyright © 2020 SpcaeTown-Subhojit. All rights reserved.
//

import UIKit
import SDWebImage
import ObjectMapper

class ViewController: UIViewController {

    @IBOutlet weak var placeholderImg: UIImageView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var moviesTableView: UITableView!
    var moviesResponse : MovieResponseModel?
    var moviesResultArray : [MoviesModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Setting up the tableview
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(movieTVC.nib(), forCellReuseIdentifier: movieTVC.reuseIdentifier)
        moviesTableView.tableFooterView = UIView()
        
        moviesTableView.isHidden = true
        self.placeholderImg.isHidden = true
        
        ///NavBar appearance setup
        let appearance = UINavigationBarAppearance(idiom: .phone)
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .black
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    
        
        self.fetchMovieAPI()
    }

    ///API Calling for fetching the movie data
    func fetchMovieAPI() {

        self.activityLoader.isHidden = false
        activityLoader.startAnimating()
        
        
        MovieAPIService.request(urlString: "movie/day?api_key=\(API_Key)", method: .get, data: nil) { (dict, error) in
            if (error != nil) {
                showAlert(title: nil, msg: "Something went wrong", controller: self)
            } else {
                self.moviesResponse = Mapper<MovieResponseModel>().map(JSONObject: dict)
                if let pgstatus = self.moviesResponse?.page, pgstatus == 1 {
                    self.moviesTableView.isHidden = false
                    if let results = self.moviesResponse?.result {
                        self.moviesResultArray = results
                        self.activityLoader.stopAnimating()
                        self.placeholderImg.isHidden = true
                        self.activityLoader.isHidden = true
                        self.moviesTableView.reloadData()
                    }

                    
                } else {
                    self.activityLoader.stopAnimating()
                    self.activityLoader.isHidden = true
                    self.placeholderImg.isHidden = false
                    showAlert(title: nil, msg: "Unable to load the data currently", controller: self)
                }
            }
        }
    }

}

///Controller extension managing the Datasource and Delegate of Tablview in order to display the content
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesResultArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "movieTVC", for: indexPath) as! movieTVC
        let item = moviesResultArray?[indexPath.row]

        cell.movieNameLbl.text = item?.title ?? ""
        let rDt = (self.releaseDateCon(dt: item?.release_date ?? ""))
        cell.releaseDateLbl.text = "Release Date : \(String(describing: rDt))"
        cell.ratingLbl.text = "\(item?.vote_average ?? 0.0) / 10"
        let imgURLString = imgPathConstant + (item?.poster_path ?? "")
        cell.posterImg.sd_setImage(with: URL(string: imgURLString), placeholderImage: UIImage(named: "placeholder"))

        cell.nameLblHeightConstraint.constant = (cell.movieNameLbl.text)?.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 180, font: UIFont(name: "Helvetica Neue", size: 22)!) ?? 0.0
        cell.releaseDtHeightConstraint.constant = (cell.ratingLbl.text)?.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 180, font: UIFont(name: "Helvetica Neue", size: 20)!) ?? 0.0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        vc.movieDetail = moviesResultArray?[indexPath.row]
         navigationController?.pushViewController(vc, animated: true)
    }
    
    func releaseDateCon(dt : String) -> String{
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: dt) {

            let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = "d MMM yyyy"

            let dtString = outputFormatter.string(from: date)
            
            return dtString
        }

        return ""
    }
}

extension String {
    /// Gets height of the String based upon provided width and font
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
}

