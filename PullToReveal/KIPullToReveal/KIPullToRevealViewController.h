//
//  PullToRevealViewController.h
//  PullToReveal
//
//  Created by Marcus Kida on 02.11.12.
//  Copyright (c) 2012 Marcus Kida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "KIPullToRevealCell.h"

@protocol KIPullToRevealDelegate <NSObject>

@optional
- (void) PullToRevealDidSearchFor:(NSString *)searchText;

@end

@interface KIPullToRevealViewController : UITableViewController

@property (nonatomic, weak) id <KIPullToRevealDelegate> pullToRevealDelegate;
@property (nonatomic, assign) BOOL centerUserLocation;
@property (nonatomic, retain) MKMapView *mapView;

@end


