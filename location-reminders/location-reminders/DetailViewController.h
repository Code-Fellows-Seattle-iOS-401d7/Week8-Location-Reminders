//
//  DetailViewController.h
//  location-reminders
//
//  Created by Corey Malek on 12/6/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;



@interface DetailViewController : UIViewController

@property(strong, nonatomic) NSString *annotationTitle;
@property(nonatomic) CLLocationCoordinate2D coordinate;

@end
