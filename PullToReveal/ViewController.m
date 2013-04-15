//
//  ViewController.m
//  PullToReveal
//
//  Created by Marcus Kida on 02.11.12.
//  Copyright (c) 2012 Marcus Kida. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <KIPullToRevealDelegate>
{
    NSArray *aLatitudes;
    NSArray *aLongitudes;
    NSArray *aTitles;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pullToRevealDelegate = self;
    self.centerUserLocation = NO;
    
	// Do any additional setup after loading the view, typically from a nib.
    
    aLatitudes = [[NSArray alloc] initWithObjects:
                  [NSNumber numberWithDouble:48.122101],
                  [NSNumber numberWithDouble:48.222201],
                  [NSNumber numberWithDouble:48.322301],
                  [NSNumber numberWithDouble:48.422401],
                  [NSNumber numberWithDouble:48.523101],
                  [NSNumber numberWithDouble:48.623201],
                  [NSNumber numberWithDouble:48.723301],
                  [NSNumber numberWithDouble:48.823401],
                  [NSNumber numberWithDouble:48.924101],
                  [NSNumber numberWithDouble:49.025101]
                  , nil];
    
    aLongitudes = [[NSArray alloc] initWithObjects:
                   [NSNumber numberWithDouble:11.601563],
                   [NSNumber numberWithDouble:11.701663],
                   [NSNumber numberWithDouble:11.801763],
                   [NSNumber numberWithDouble:11.901863],
                   [NSNumber numberWithDouble:12.001963],
                   [NSNumber numberWithDouble:12.101563],
                   [NSNumber numberWithDouble:12.201663],
                   [NSNumber numberWithDouble:12.301763],
                   [NSNumber numberWithDouble:12.401863],
                   [NSNumber numberWithDouble:12.501963],
                   [NSNumber numberWithDouble:12.602563]
                   , nil];
    
    aTitles = [[NSArray alloc] initWithObjects:
               @"Apple Store",
               @"Gravis",
               @"FundK",
               @"Aldi",
               @"Lidl",
               @"REWE",
               @"Netto",
               @"Saturn",
               @"MediaMarkt",
               @"Medimax"
               , nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Datasource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [aTitles count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *stCellIdentifier = @"Cell";
    KIPullToRevealCell *cell = (KIPullToRevealCell *)[tableView dequeueReusableCellWithIdentifier:stCellIdentifier];
    
    if(!cell)
        cell = (KIPullToRevealCell *)[KIPullToRevealCell cellFromNibNamed:NSStringFromClass([KIPullToRevealCell class])];

    cell.pointLocation = CLLocationCoordinate2DMake([[aLatitudes objectAtIndex:indexPath.row] doubleValue], [[aLongitudes objectAtIndex:indexPath.row] doubleValue]);
    cell.titleLabel.text = [NSString stringWithFormat:@"%@", [aTitles objectAtIndex:indexPath.row]];
    cell.distanceLabel.text = [NSString stringWithFormat:@"~ 0.0 km"];
    
    return cell;
}

#pragma mark - TableView Delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - PullToReveal Delegate
- (void) PullToRevealDidSearchFor:(NSString *)searchText
{
    NSLog(@"PullToRevealDidSearchFor: %@", searchText);
}

@end
