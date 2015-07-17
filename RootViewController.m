//
//  RootViewController.m
//  HangOutApp
//
//  Created by Alex Santorineos on 7/7/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "RootViewController.h"
#import "HangOutPlace.h"
#import "DetailVCViewController.h"

@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property CLLocationManager *locationManager;
@property NSMutableArray *restaurants;
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
                                                                    //make sure "MKCoordinateSpanMake" is not too small
    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(1, 1));

    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];

    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {

        NSArray *mapItems = response.mapItems;
        MKMapItem *mapItem = [[MKMapItem alloc]init];

       NSMutableArray *mutableArray = [NSMutableArray new];

        if (mapItems.count <=1) {
            NSLog(@"no locations");
            NSLog(@"%lu",(unsigned long)mapItems.count);

            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"cannot detect any hangout place" message:nil delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
            [alertView show];
        }else{

        for (int i = 0; i<4; i++) {
            mapItem = [mapItems objectAtIndex:i];

            CLLocationDistance distanceInMeters = [mapItem.placemark.location distanceFromLocation:self.locationManager.location];
            float mileD = distanceInMeters / 1609.34;

            HangOutPlace *hangOutPlace= [[HangOutPlace alloc]init];
            hangOutPlace.mapItem = mapItem;

            hangOutPlace.distance = mileD;
            // hangOutPlace.distance
            [mutableArray addObject:hangOutPlace];
        }}
        NSSortDescriptor *sortD = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:true];

        NSArray *sort = [mutableArray sortedArrayUsingDescriptors:@[sortD]];

        self.restaurants = [sort mutableCopy];
        

        [self.tableView reloadData];
    }];
}

-(void)updateCurrentLocation{

    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
}


-(void)reverseGeoCode:(CLLocation *)location{
    CLGeocoder *geoCoder = [CLGeocoder new];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        //        NSLog(@"%@",placemarks);

        //what r all the objects in the nsarray? r there more than one object?
        CLPlacemark *placemark = placemarks.firstObject;

        NSLog(@"%@",placemark);

//        self.textView.text = [NSString stringWithFormat:@"%@ %@ %@",placemark.locality, placemark.thoroughfare, placemark.postalCode];
        NSLog(@"%@ and %@ and %@",placemark.locality, placemark.thoroughfare, placemark.postalCode);

        [self findBars:location];
    }];
    
}
#pragma mark locationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{

    for (CLLocation * location in locations) {
        if (location.verticalAccuracy <1000 && location.horizontalAccuracy <1000) {
            [self findBars:location];
            NSLog(@"%@----+++++",location);
            [self reverseGeoCode:location];
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

    MKMapItem *mapItem = [[self.restaurants objectAtIndex:indexPath.row]mapItem];

    cell.textLabel.text = mapItem.name;
    

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    DetailVCViewController *dVc = segue.destinationViewController;
    MKMapItem *mapItem = [[self.restaurants objectAtIndex:self.tableView.indexPathForSelectedRow.row]mapItem];
    dVc.mapItem = mapItem;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.restaurants.count;
}
@end
