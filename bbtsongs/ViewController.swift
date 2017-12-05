//
//  ViewController.swift
//  test
//
//  Created by Value edge solution on 05/09/17.
//  Copyright © 2017 Value edge solution. All rights reserved.
//

import UIKit
class ViewController: BaseViewController,UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var data:[RepoSong]=[]
    var filteredData: [RepoSong]=[]    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        tableView.delegate=self
        tableView.dataSource=self
        searchBar.delegate = self
        filteredData = data
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 10.0
        self.tableView.tableFooterView = UIView()
        refreshControl.addTarget(self, action: #selector(refreshSongs(_:)), for: .valueChanged)
        Helpers.webServiceRequest(url: Constants.WebServiceUrls.baseUrl, viewController: self){songs in
            print(songs.first?.name! ?? "")
            self.data=songs
            self.filteredData = self.data
            self.tableView.reloadData()
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc private func refreshSongs(_ sender: Any) {
        Helpers.webServiceRequest(url: Constants.WebServiceUrls.baseUrl, viewController: self){songs in
            print(songs.first?.name! ?? "")
            self.data=songs
            self.filteredData = self.data
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "identifier"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SongCell  else {
            fatalError("The dequeued cell is not an instance of RateCardCell.")
        }
        let song=filteredData[indexPath.row]
        cell.lblName.text=song.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let chords=filteredData[indexPath.row].chords{
            ChordsVC.chords=chords
            ChordsVC.name = filteredData[indexPath.row].name!
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChordsVC") as!  ChordsVC
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? data : data.filter { (item: RepoSong) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.name?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class SongCell : UITableViewCell{   
    
    @IBOutlet var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

