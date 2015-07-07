//
//  LocationManager.m
//  HangOutApp
//
//  Created by Alex Santorineos on 7/7/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager ()<CLLocationManagerDelegate>

@end



@implementation LocationManager


-(id)init{
    self= [super init];

    if (self) {

        self.locationManager.delegate = self;

        [self updateCurrentLocation];

    }
    return self;

}


-(void)updateCurrentLocation{

    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{


    for (CLLocation*location in locations) {
        NSLog(@"%@",location);
    }
    [self.locationManager stopUpdatingLocation];

}


    

@end
