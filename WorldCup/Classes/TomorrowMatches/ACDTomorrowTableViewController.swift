//
//  ACDTomorrowTableViewController.swift
//  WorldCup
//
//  Created by Acid Studios on 20/06/14.
//  Copyright (c) 2014 Acid Studios. All rights reserved.
//

import UIKit

class ACDTomorrowTableViewController: UITableViewController {
    var tomorrow: MatchModel[] = Array()
    
    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }
    
    init(coder aDecoder: NSCoder!)  {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool)  {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        var request = NSURLRequest(URL: NSURL(string: "http://worldcup.sfg.io/matches/tomorrow"))
        var session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            var json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as AnyObject[]
            
            if(json.count > 0) {
                var matches: MatchModel[] = json.map {
                    var model: MatchModel = MatchModel(dict: $0 as NSDictionary)
                    return model
                }
                
                self.tomorrow = matches
                self.tableView.reloadData()
            }
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }).resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return self.tomorrow.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!  {
        let cell = tableView.dequeueReusableCellWithIdentifier("TomorrowMatchCell", forIndexPath: indexPath) as UITableViewCell
        
        var match = self.tomorrow[indexPath.row]
        
        cell.textLabel.text = "\(match.home_team.country) V.S \(match.away_team.country)"
        cell.detailTextLabel.text = "Stadium: \(match.location)"
        
        return cell
    }

}
