//
//  DetailVCViewController.m
//  HangOutApp
//
//  Created by Alex Santorineos on 7/10/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "DetailVCViewController.h"

@interface DetailVCViewController ()


@end

@implementation DetailVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.mapItem.name;

    self.phoneLabel.text = self.mapItem.phoneNumber;
    if (self.mapItem.url == nil) {
        self.urlButton.alpha = 0;
    }

}
- (IBAction)onUrlButtonTapped:(UIButton *)sender {
    NSURL *url = self.mapItem.url;
    [[UIApplication sharedApplication] openURL:url];

}



- (IBAction)getDirectionsButtonTapped:(id)sender {
}

- (IBAction)inviteButtonTapped:(id)sender {
}

@end
