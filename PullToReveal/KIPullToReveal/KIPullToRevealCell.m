//
//  PullToRevealCell.m
//  PullToReveal
//
//  Created by Marcus Kida on 05.11.12.
//  Copyright (c) 2012 Marcus Kida. All rights reserved.
//

#import "KIPullToRevealCell.h"

@interface KIPullToRevealCell ()
{
    @public
    CLLocationCoordinate2D _pointLocation;
    IBOutlet UIImageView *_iconImageView;
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_distanceLabel;
}
@end

@implementation KIPullToRevealCell

@synthesize pointLocation = _pointLocation;
@synthesize iconImageView = _iconImageView;
@synthesize titleLabel = _titleLabel;
@synthesize distanceLabel = _distanceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    }
    return self;
}

+ (KIPullToRevealCell *)cellFromNibNamed:(NSString *)nibName
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    KIPullToRevealCell *customCell = nil;
    NSObject* nibItem = nil;
    while ((nibItem = [nibEnumerator nextObject]) != nil)
    {
        if ([nibItem isKindOfClass:[KIPullToRevealCell class]])
        {
            customCell = (KIPullToRevealCell *)nibItem;
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
