//
//  ViewController.swift
//  News
//
//  Created by Cihan on 22.01.2024.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    private var newsTableViewModel :NewsTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight  = UITableView.automaticDimension
        
        getData()
    }
    
    func getData() {
        let url =  URL(string: "https://raw.githubusercontent.com/atilsamancioglu/BTK-iOSDataSet/master/dataset.json")
        
        WebService().DownloadTheNews(url: url!) { (news) in
            if let news = news {
                self.newsTableViewModel = NewsTableViewModel(newsList: news)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsTableViewModel == nil ? 0 : self.newsTableViewModel.numberOfRowaInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsCell
        let newViewModel = self.newsTableViewModel?.newsAtIndexPath(indexPath.row)
        cell.labelTitle.text = newViewModel?.title
        cell.labelStory.text = newViewModel?.story
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


}

