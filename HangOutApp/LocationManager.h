//
//  LocationManager.h
//  HangOutApp
//
//  Created by Alex Santorineos on 7/7/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface LocationManager : NSObject
@property CLLocationManager *locationManager;


-(void)updateCurrentLocation;
@end
