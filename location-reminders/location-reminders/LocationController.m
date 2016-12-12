//
//  LocationController.m
//  location-reminders
//
//  Created by Corey Malek on 12/6/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import "LocationController.h"

@interface LocationController()<CLLocationManagerDelegate>

@end

@implementation LocationController

+(instancetype)sharedController{
    
    static LocationController *sharedController;
    
    //Got this from "dispatch once" search in utilities
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[LocationController alloc]init];
        
    });
    
    return sharedController;
    
}


-(instancetype)init{
    
    self = [super init];
    
    if(self){
        _manager = [[CLLocationManager alloc]init];
        _manager.delegate = self;
        
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        _manager.distanceFilter = 100;
        
        [_manager requestAlwaysAuthorization];
        
        
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //come back to this
    [self.delegate locationControllerUpdatedLocation:locations.lastObject];
    [self setLocation:locations.lastObject];
    
}














@end
