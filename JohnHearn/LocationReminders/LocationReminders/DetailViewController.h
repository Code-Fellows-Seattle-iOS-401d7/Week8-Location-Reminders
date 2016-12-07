//
//  DetailViewController.h
//  LocationReminders
//
//  Created by John D Hearn on 12/6/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface DetailViewController : UIViewController
@property(strong, nonatomic)NSString *annotationTitle;
@property(nonatomic)CLLocationCoordinate2D coordinate;

@end
