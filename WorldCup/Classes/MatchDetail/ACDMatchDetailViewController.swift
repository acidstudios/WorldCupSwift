//
//  ACDMatchDetailViewController.swift
//  WorldCup
//
//  Created by Acid Studios on 20/06/14.
//  Copyright (c) 2014 Acid Studios. All rights reserved.
//

import UIKit

class ACDMatchDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var awayTeamLabel: UILabel
    @IBOutlet var homeTeamLabel: UILabel
    @IBOutlet var homeTeamScoreLabel: UILabel
    @IBOutlet var awayTeamScoreLabel: UILabel
    @IBOutlet var segmentedControl: UISegmentedControl
    @IBOutlet var eventsTableView: UITableView
    
    var GameDetail: MatchModel = MatchModel()
    var gameEvents: GameEventModel[] = Array()
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        homeTeamLabel.text = self.GameDetail.home_team.fifa_code
        awayTeamLabel.text = self.GameDetail.away_team.fifa_code
        homeTeamScoreLabel.text = "\(self.GameDetail.home_team.goals)"
        awayTeamScoreLabel.text = "\(self.GameDetail.away_team.goals)"
        
        segmentedControl.setTitle("\(self.GameDetail.home_team.country)'s Events", forSegmentAtIndex: 0)
        segmentedControl.setTitle("\(self.GameDetail.away_team.country)'s Events", forSegmentAtIndex: 1)
        
        segmentedControl.selectedSegmentIndex = 0
        gameEvents = GameDetail.home_team_events
        self.eventsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark UITableView
    
    func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return self.gameEvents.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!  {
        let cell = tableView.dequeueReusableCellWithIdentifier("GameEventCell", forIndexPath: indexPath) as UITableViewCell
        
        var event = self.gameEvents[indexPath.row] as GameEventModel
        cell.textLabel.text = event.type_of_event
        
        return cell
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func segmentedControlValueChange(sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0) {
            gameEvents = GameDetail.home_team_events
        } else {
            gameEvents = GameDetail.away_team_events
        }
        
        self.eventsTableView.reloadData()
    }
}
