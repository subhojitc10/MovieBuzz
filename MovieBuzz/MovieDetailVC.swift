//
//  MovieDetailVC.swift
//  MovieBuzz
//
//  Created by GOQii-Subhojit on 06/11/20.
//  Copyright © 2020 SpcaeTown-Subhojit. All rights reserved.
//

import UIKit

enum Language : String{
    case en = "English"
    case fr = "French"
    case hi = "Hindi"
    
    func printName() -> String {
        return self.rawValue
    }
}

class MovieDetailVC: UIViewController {
    
    @IBOutlet weak var backdropImg: UIImageView!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var releaseYrLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var movieDetailLbl: UILabel!
    @IBOutlet weak var langValLbl: UILabel!
    @IBOutlet weak var popularityValLbl: UILabel!
    @IBOutlet weak var voteValLbl: UILabel!
    @IBOutlet weak var ratedValLbl: UILabel!
    @IBOutlet weak var genreValLbl: UILabel!
    @IBOutlet weak var imgBackView: UIView!
    @IBOutlet weak var nameLblHtConstraint: NSLayoutConstraint!
    @IBOutlet weak var overviewHtConstraint: NSLayoutConstraint!
    @IBOutlet weak var overlayView: UIView!
    
    var movieDetail : MoviesModel?
    var genreDict : Dictionary<Int, String>?
     

    override func viewDidLoad() {
        super.viewDidLoad()

        ///Initiating all the data called
        instantiateValues()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ///Disabling Nav bar UI
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    /// Performs the initialisation of all the possible labels present in screen giiving details about the movie
    func instantiateValues() {
        
        ///Contains all possible genre directory
        genreDict = [14:"Fantasy", 16:"Animation", 12:"Adventure", 35:"Comedy", 10751:"Family", 28:"Action", 80:"Crime", 99:"Documentary", 18:"Drama", 36:"History", 27:"Horror", 10402:"Music", 9648:"Mystery", 878:"Science Fiction", 10749:"Romance", 10770:"TV Movie", 53:"Thriller", 10752:"War", 37:"Western"]
        
        overlayView.addBlackGradientLayerInForeground(frame: view.bounds, colors:[.clear, .black])
        imgBackView.addShadowLayer(view: imgBackView)
        nameLblHtConstraint.constant = (movieDetail?.title ?? "")?.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 20, font: UIFont(name: "Helvetica Neue", size: 22)!) ?? 0.0
        overviewHtConstraint.constant = (movieDetail?.overview ?? "")?.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 20, font: UIFont(name: "Helvetica Neue", size: 14)!) ?? 0.0
        
        
        posterImg.sd_setImage(with: URL(string: imgPathConstant + (movieDetail?.poster_path ?? "")), placeholderImage: UIImage(named: "placeholder.png"))
        backdropImg.sd_setImage(with: URL(string: imgBackPathConstant + (movieDetail?.backdrop_path ?? "")), placeholderImage: UIImage(named: "placeholder.png"))
        
        movieNameLbl.text = movieDetail?.title
        movieDetailLbl.text = movieDetail?.overview
        releaseYrLbl.text = getYear(yrLbl: movieDetail?.release_date ?? "")
        ratingLbl.text = String(movieDetail?.vote_average ?? 0.0)//getYear(yrLbl: String(movieDetail?.release_date ?? ""))
        voteValLbl.text = String(movieDetail?.vote_count ?? 0)
        ratedValLbl.text = (movieDetail?.adult ?? false) ? "A" : "UA"
        langValLbl.text = getLang(langLbl: movieDetail?.original_language ?? "")
        popularityValLbl.text = String(format: "%.2f", movieDetail?.popularity ?? 0.0) //String( ?? 0.0)
        genreValLbl.text = getGenres(genres: movieDetail?.genre_ids ?? [])
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
    /// Performs back action
    /// - Parameter sender: Takes sender
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension MovieDetailVC {
    
    /// Filters and finds all possible genres for specific movie from genre ids
    /// - Parameter genres: array of genre ids
    /// - Returns: String of genres
    func getGenres(genres : [Int]) -> String {
        var genreStr : [String] = []
        for item in genres {
            if let keyExists = genreDict?[item] {
                genreStr.append(keyExists)
            }
        }
        
        return genreStr.joined(separator: ", ")
    }
    
    /// Converts the date date string to simple year string
    /// - Parameter yrLbl: the release dt string
    /// - Returns: year string
    func getYear(yrLbl : String) -> String {
        let yr = yrLbl.components(separatedBy: "-")
        return yr[0]
    }
    
    /// Identifies the Language of movie based on the symbol
    /// - Parameter langLbl: language symbol
    /// - Returns: language absolute string
    func getLang(langLbl : String) -> String {
        let lang = Language(rawValue: langLbl)
        var tmpLang = ""
        switch lang {
            case  .fr :
                tmpLang = "French"
                break
            
            case  .en :
                tmpLang = "english"
                break
            
            case  .hi :
                tmpLang = "Hindi"
                break
            
            default :
                tmpLang = "English"
                break
            
        }
        
        return tmpLang
        
    }
}
