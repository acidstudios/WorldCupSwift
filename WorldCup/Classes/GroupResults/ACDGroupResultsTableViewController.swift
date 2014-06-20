//
//  ACDGroupResultsTableViewController.swift
//  WorldCup
//
//  Created by Acid Studios on 19/06/14.
//  Copyright (c) 2014 Acid Studios. All rights reserved.
//
import Foundation
import UIKit

class ACDGroupResultsTableViewController: UITableViewController {
    var groups : CountryModel[] = Array()
    
    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool)  {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        var url = NSURL(string: "http://worldcup.sfg.io/group_results")
        var request = NSURLRequest(URL: url)
        var session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            var json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as AnyObject[]
            
            if(json.count > 0) {
                var countries: CountryModel[] = json.map {
                    var countryModel : CountryModel = CountryModel()
                    countryModel.country = $0["country"] as? String
                    countryModel.alternate_name = $0["alternate_name"] as? String
                    countryModel.fifa_code = $0["fifa_code"] as? String
                    countryModel.goals_for = $0["goals_for"] as? Int
                    countryModel.goals_against = $0["goals_against"] as? Int
                    countryModel.wins = $0["wins"] as? Int
                    countryModel.losses = $0["losses"] as? Int
                    countryModel.draws = $0["draws"] as? Int
                    countryModel.knocked_out = $0["knocked_out"] as? Int
                    return countryModel
                }
                self.groups = countries
                
                self.tableView.reloadData()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
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
        return self.groups.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        let cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("CountryGroup", forIndexPath: indexPath) as UITableViewCell
        let country = self.groups[indexPath.row] as CountryModel
        cell.textLabel.text = country.country
        cell.detailTextLabel.text = "Wins: \(country.wins) Losses: \(country.losses) GF: \(country.goals_for) GA: \(country.goals_against)"
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)  {
        if(segue.identifier == "ShowCountryMatchesSegue") {
            var destination = segue.destinationViewController as ACDCountryTableViewController
            var indexPath = self.tableView.indexPathForSelectedRow()
            var country = self.groups[indexPath.row]
            
            destination.country = country
        }
    }


}
