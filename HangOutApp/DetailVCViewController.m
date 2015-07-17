//
//  DetailVCViewController.m
//  HangOutApp
//
//  Created by Alex Santorineos on 7/10/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "DetailVCViewController.h"

@interface DetailVCViewController ()
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;


@end

@implementation DetailVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.mapItem.name;

    [self.phoneButton setTitle:self.mapItem.phoneNumber forState:UIControlStateNormal];
    self.phoneLabel.text = self.mapItem.phoneNumber;
    if (self.mapItem.url == nil) {
        self.urlButton.alpha = 0;
    }

}
- (IBAction)onUrlButtonTapped:(UIButton *)sender {
    NSURL *url = self.mapItem.url;
    [[UIApplication sharedApplication] openURL:url];

}

- (IBAction)phoneButtonTapped:(id)sender {

    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:self.phoneButton.titleLabel.text];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}


- (IBAction)getDirectionsButtonTapped:(id)sender {

   MKMapItem *endingItem = [[MKMapItem alloc] initWithPlacemark:self.mapItem.placemark];
    endingItem.name = self.mapItem.name;

    NSMutableDictionary *launchOptions = [[NSMutableDictionary alloc] init];
    [launchOptions setObject:MKLaunchOptionsDirectionsModeDriving forKey:MKLaunchOptionsDirectionsModeKey];

    [endingItem openInMapsWithLaunchOptions:launchOptions];

}

- (IBAction)inviteButtonTapped:(id)sender {
}

@end
