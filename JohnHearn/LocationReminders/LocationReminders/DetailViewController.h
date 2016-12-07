//
//  DetailViewController.h
//  LocationReminders
//
//  Created by John D Hearn on 12/6/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

#import "Reminder.h"
#import "LocationController.h"

typedef void(^DetailViewControllerCompletion)(MKCircle *circle);

@interface DetailViewController : UIViewController
@property(strong, nonatomic)NSString *annotationTitle;
@property(nonatomic)CLLocationCoordinate2D coordinate;

@property(copy, nonatomic) DetailViewControllerCompletion completion;

@end
