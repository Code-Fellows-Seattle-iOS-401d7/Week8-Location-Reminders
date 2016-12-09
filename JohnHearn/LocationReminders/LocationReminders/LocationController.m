//
//  LocationController.m
//  LocationReminders
//
//  Created by John D Hearn on 12/6/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

#import "LocationController.h"

@interface LocationController()<CLLocationManagerDelegate>
@end

@implementation LocationController

+(instancetype)sharedController{
    static LocationController *sharedController;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[LocationController alloc] init];
    });

    return sharedController;
}

-(instancetype)init{
    self = [super init];

    if(self) {
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;

        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        _manager.distanceFilter = 100;

        [_manager requestAlwaysAuthorization];
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self.delegate locationControllerUpdatedLocation:locations.lastObject];
    [self setLocation:locations.lastObject];
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    NSLog(@"Started monitoring region for: %@", region);
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"User DID ENTER REGION: %@", region);
}

-(void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{
    NSLog(@"ERROR!!");
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"ERROR!!");
}

-(void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error{
    NSLog(@"ERROR!!");
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"Left Region!");

}

@end


