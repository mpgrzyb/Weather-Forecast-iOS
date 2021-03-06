//
//  AddCityViewController.h
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 31.12.2013.
//  Copyright (c) 2013 Mateusz Grzyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AddCityViewController : UIViewController
@property (retain, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *message;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *cellTitle;
@property (strong, nonatomic) IBOutlet UILabel *cellDetail;

@property (nonatomic, retain) NSMutableData* responseData;
@property (strong, nonatomic) NSMutableArray *citiesList;

-(IBAction)useGeolocationData:(id)sender;
@end
