//
//  RootViewController.m
//  HangOutApp
//
//  Created by Alex Santorineos on 7/7/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "RootViewController.h"
#import "HangOutPlace.h"

@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property CLLocationManager *locationManager;
@property NSMutableArray *mutableArray;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self updateCurrentLocation];
}
- (IBAction)segmentedControl:(id)sender {

    [self updateCurrentLocation];
}

-(void)viewWillAppear:(BOOL)animated{
    [self updateCurrentLocation];
}
-(void)findBars:(CLLocation *)location{

    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc]init];

    if (self.segmentedControl.selectedSegmentIndex == 0) {
        request.naturalLanguageQuery = @"beer";
    }else{
        request.naturalLanguageQuery = @"coffee";
    }

    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(2, 2));

    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];

    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {

        NSArray *mapItems = response.mapItems;
        MKMapItem *mapItem = [[MKMapItem alloc]init];

       NSMutableArray *mutableArray = [NSMutableArray new];

        for (int i = 0; i<7; i++) {
            mapItem = [mapItems objectAtIndex:i];

            CLLocationDistance distanceInMeters = [mapItem.placemark.location distanceFromLocation:self.locationManager.location];
            float mileD = distanceInMeters / 1609.34;

            HangOutPlace *hangOutPlace= [[HangOutPlace alloc]init];
            hangOutPlace.mapItem = mapItem;

            hangOutPlace.distance = mileD;


            // hangOutPlace.distance
            [mutableArray addObject:hangOutPlace];
        }
        NSSortDescriptor *sortD = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:true];

        NSArray *sort = [mutableArray sortedArrayUsingDescriptors:@[sortD]];

        self.mutableArray = [sort mutableCopy];
        

        [self.tableView reloadData];
    }];
}

-(void)updateCurrentLocation{

    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark locationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{


    for (CLLocation * location in locations) {
        if (location.verticalAccuracy <1000 && location.horizontalAccuracy <1000) {
            //            NSLog(@"%@",location);
            [self.locationManager stopUpdatingLocation];
            
            [self findBars:location];
        }
        [self.locationManager stopUpdatingLocation];
        
    }
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    NSLog(@"%@",error.localizedDescription);
}

#pragma mark tableview datasource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];

    MKMapItem *mapItem = [[self.mutableArray objectAtIndex:indexPath.row]mapItem];

    cell.textLabel.text = mapItem.name;

    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.mutableArray.count;
}
@end
