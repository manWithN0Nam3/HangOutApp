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
    NSLog(@"%@",self.mapItem);
    NSLog(@"%@",self.mapItem.url);

    NSLog(@"placemark:%@",self.mapItem.placemark);
    self.phoneLabel.text = self.mapItem.phoneNumber;

}
- (IBAction)onUrlButtonTapped:(UIButton *)sender {


//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"HTTP://WWW.APPLE.COM"]];

    NSURL *url = self.mapItem.url;
    [[UIApplication sharedApplication] openURL:url];

}



- (IBAction)getDirectionsButtonTapped:(id)sender {
}

- (IBAction)inviteButtonTapped:(id)sender {
}

@end
