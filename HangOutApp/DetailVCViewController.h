//
//  DetailVCViewController.h
//  HangOutApp
//
//  Created by Alex Santorineos on 7/10/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DetailVCViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *getDirectionsButton;
@property (weak, nonatomic) IBOutlet UIButton *inviteButton;
@property MKMapItem *mapItem;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *urlButton;

@end
