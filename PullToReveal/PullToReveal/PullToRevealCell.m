//
//  PullToRevealCell.m
//  PullToReveal
//
//  Created by Marcus Kida on 05.11.12.
//  Copyright (c) 2012 Marcus Kida. All rights reserved.
//

#import "PullToRevealCell.h"

@interface PullToRevealCell ()
{
    @public
    CLLocationCoordinate2D pointLocation;
    IBOutlet UIImageView *iconImageView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *distanceLabel;
}
@end

@implementation PullToRevealCell

@synthesize pointLocation;
@synthesize iconImageView;
@synthesize titleLabel;
@synthesize distanceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    }
    return self;
}

+ (PullToRevealCell *)cellFromNibNamed:(NSString *)nibName
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    PullToRevealCell *customCell = nil;
    NSObject* nibItem = nil;
    while ((nibItem = [nibEnumerator nextObject]) != nil)
    {
        if ([nibItem isKindOfClass:[PullToRevealCell class]])
        {
            customCell = (PullToRevealCell *)nibItem;
            break;
        }
    }
    return customCell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
