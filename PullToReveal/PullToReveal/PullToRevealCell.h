//
//  PullToRevealCell.h
//  PullToReveal
//
//  Created by Marcus Kida on 05.11.12.
//  Copyright (c) 2012 Marcus Kida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PullToRevealCell : UITableViewCell

+ (PullToRevealCell *)cellFromNibNamed:(NSString *)nibName;

@property (nonatomic, assign) CLLocationCoordinate2D pointLocation;
@property (nonatomic, retain) IBOutlet UIImageView *iconImageView;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *distanceLabel;

@end
