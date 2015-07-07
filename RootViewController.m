//
//  RootViewController.m
//  HangOutApp
//
//  Created by Alex Santorineos on 7/7/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property CLLocationManager *locationManager;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self updateCurrentLocation];
}

-(void)viewWillAppear:(BOOL)animated{
    [self updateCurrentLocation];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    return cell;

}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{


    for (CLLocation * location in locations) {
        if (location.verticalAccuracy <1000 && location.horizontalAccuracy <1000) {
            //            NSLog(@"%@",location);


            [self.locationManager stopUpdatingLocation];
            
        }
        NSLog(@"%@",location);
        [self.locationManager stopUpdatingLocation];

    }


}
-(void)updateCurrentLocation{

    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];

}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    NSLog(@"%@",error.localizedDescription);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
@end
