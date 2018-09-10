//
//  ViewController.swift
//  Flashcards
//
//  Created by Sergei Novikov on 10/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import UIKit

class SourcesViewController: BaseViewController {
  var sources: [Source] = []
  var selectedSourceID: Int?
  
  lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(SourcesViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    refreshControl.tintColor = UIColor.lightGray
    
    return refreshControl
  }()
  
  @IBOutlet weak var sourcesTableView: UITableView!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    sourcesTableView.separatorInset = UIEdgeInsets.zero
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    sourcesTableView.addSubview(self.refreshControl)

    repository.getSources() { result in
      if case .success(let sources) = result {
        self.sources = sources
      }

      DispatchQueue.main.async {
        self.sourcesTableView.reloadData()
      }
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "openSource":
      let sourceController = segue.destination as! SourceViewController
      sourceController.id = selectedSourceID!
    case "openAuth":
      Store.instance.token = nil
    default: break
    }
  }
  
  @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
    repository.getSources() { result in
      if case .success(let sources) = result {
        self.sources = sources
      }
      
      DispatchQueue.main.async {
        self.sourcesTableView.reloadData()
        refreshControl.endRefreshing()
      }
    }
  }
}

extension SourcesViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sources.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "source")
    cell.textLabel?.text = sources[indexPath.row].title
    cell.textLabel?.font = UIFont(name: "ArialRoundedMTBold", size: CGFloat(17))

    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedSourceID = sources[indexPath.row].id
    
    performSegue(withIdentifier: "openSource", sender: self)
  }
}
