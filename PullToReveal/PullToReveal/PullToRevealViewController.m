//
//  PullToRevealViewController.m
//  PullToReveal
//
//  Created by Marcus Kida on 02.11.12.
//  Copyright (c) 2012 Marcus Kida. All rights reserved.
//

#define kTableViewContentInsetX     200.0f
#define kAnimationDuration          0.5f

#import "PullToRevealViewController.h"

@interface PullToRevealViewController () <UIScrollViewDelegate, UITextFieldDelegate, MKMapViewDelegate>
{
    @private
    UIToolbar *toolbar;
    UITextField *searchTextField;
    BOOL scrollViewIsDraggedDownwards;
    double lastDragOffset;
    
    @public
    MKMapView *mapView;
    __weak id <PullToRevealDelegate> pullToRevealDelegate;
    BOOL centerUserLocation;
}
@end

@implementation PullToRevealViewController

@synthesize pullToRevealDelegate;
@synthesize centerUserLocation;
@synthesize mapView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initializeMapView];
    [self initalizeToolbar];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self displayMapViewAnnotationsForTableViewCells];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods
- (void) initializeMapView
{
    [self.tableView setContentInset:UIEdgeInsetsMake(kTableViewContentInsetX,0,0,0)];
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, self.tableView.contentInset.top*-1, self.tableView.bounds.size.width, self.tableView.contentInset.top)];
    [mapView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [mapView setShowsUserLocation:YES];
    [mapView setUserInteractionEnabled:NO];
    
    if(centerUserLocation)
    {
        [self centerToUserLocation];
        [self zoomToUserLocation];
    }
        
    [self.tableView insertSubview:mapView aboveSubview:self.tableView];
}

- (void) initalizeToolbar
{
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, -50, self.tableView.bounds.size.width, 50)];
    [toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 7, toolbar.bounds.size.width-20, 30)];
    [searchTextField setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [searchTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [searchTextField setReturnKeyType:UIReturnKeySearch];
    [searchTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [searchTextField addTarget:self action:@selector(searchTextFieldBecomeFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
    [searchTextField setDelegate:self];
    [toolbar addSubview:searchTextField];
    [self.tableView insertSubview:toolbar aboveSubview:self.tableView];
}

- (void) centerToUserLocation
{
    [mapView setCenterCoordinate:mapView.userLocation.coordinate animated:YES];
}

- (void) zoomToUserLocation
{
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.2;
    mapRegion.span.longitudeDelta = 0.2;
    [mapView setRegion:mapRegion animated: YES];
}

#pragma mark - ScrollView Delegate
- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    double contentOffset = scrollView.contentOffset.y;
    lastDragOffset = contentOffset;

    if(contentOffset < kTableViewContentInsetX*-1)
    {
        [self zoomMapToFitAnnotations];
        [mapView setUserInteractionEnabled:YES];
        
        [UIView animateWithDuration:kAnimationDuration
                         animations:^()
         {
             [self.tableView setContentInset:UIEdgeInsetsMake(self.tableView.bounds.size.height,0,0,0)];
             [self.tableView scrollsToTop];
         }];
    }
    else if (contentOffset >= kTableViewContentInsetX*-1)
    {
        [mapView setUserInteractionEnabled:NO];
        
        [UIView animateWithDuration:kAnimationDuration
                         animations:^()
         {
             [self.tableView setContentInset:UIEdgeInsetsMake(kTableViewContentInsetX,0,0,0)];

         }];
        
        if(centerUserLocation)
        {
            [self centerToUserLocation];
            [self zoomToUserLocation];
        }
        
        [self.tableView scrollsToTop];
    }
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    double contentOffset = scrollView.contentOffset.y;
    
    if (contentOffset < lastDragOffset)
        scrollViewIsDraggedDownwards = YES;
    else
        scrollViewIsDraggedDownwards = NO;

    if (!scrollViewIsDraggedDownwards)
    {
        [mapView setFrame:
         CGRectMake(0, self.tableView.contentInset.top*-1, self.tableView.bounds.size.width, self.tableView.contentInset.top)
         ];
        [mapView setUserInteractionEnabled:NO];

        [self.tableView setContentInset:UIEdgeInsetsMake(kTableViewContentInsetX,0,0,0)];
        
        if(centerUserLocation)
        {
            [self centerToUserLocation];
            [self zoomToUserLocation];
        }
        
        [self.tableView scrollsToTop];
    }

    if(contentOffset >= -50)
    {
        [toolbar removeFromSuperview];
        [toolbar setFrame:CGRectMake(0, contentOffset, self.tableView.bounds.size.width, 50)];
        [self.tableView addSubview:toolbar];
    }
    else if(contentOffset < 0)
    {
        [toolbar removeFromSuperview];
        [toolbar setFrame:CGRectMake(0, -50, self.tableView.bounds.size.width, 50)];
        [self.tableView insertSubview:toolbar aboveSubview:self.tableView];
        
        // Resize map to viewable size
        [mapView setFrame:
         CGRectMake(0, self.tableView.bounds.origin.y, self.tableView.bounds.size.width, contentOffset*-1)
         ];
        [self zoomMapToFitAnnotations];
    }
    
    if(centerUserLocation)
    {
        [self centerToUserLocation];
        [self zoomToUserLocation];
        [self displayMapViewAnnotationsForTableViewCells];
    }
}

#pragma mark - TextField Delegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(pullToRevealDelegate && [pullToRevealDelegate respondsToSelector:@selector(PullToRevealDidSearchFor:)])
        [[self pullToRevealDelegate] PullToRevealDidSearchFor:textField.text];
    
    [searchTextField resignFirstResponder];
    return YES;
}

#pragma mark - SearchTextField
- (void) searchTextFieldBecomeFirstResponder: (id)sender
{
    [UIView animateWithDuration:kAnimationDuration
                     animations:^()
     {
         [self.tableView setContentInset:UIEdgeInsetsMake(kTableViewContentInsetX+50,0,0,0)];
         [mapView setFrame:
          CGRectMake(0, self.tableView.contentInset.top*-1, self.tableView.bounds.size.width, self.tableView.contentInset.top)
          ];
         [mapView setUserInteractionEnabled:NO];
         
         if(centerUserLocation)
         {
             [self centerToUserLocation];
             [self zoomToUserLocation];
         }
         
         [self.tableView scrollsToTop];
     }];
    [searchTextField becomeFirstResponder];
}
#pragma mark - MapView
- (void) displayMapViewAnnotationsForTableViewCells
{
    NSLog(@"displayMapViewAnnotationsForTableViewCells");
    // ATM this is only working for one section !!!
    NSLog(@"self.tableView numberOfRowsInSection:0] = %d", [self.tableView numberOfRowsInSection:0]);
    [mapView removeAnnotations:mapView.annotations];
    for (int i = 0; i < [self.tableView numberOfRowsInSection:0]; i++)
    {
        PullToRevealCell *cell = (PullToRevealCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if(CLLocationCoordinate2DIsValid(cell.pointLocation) &&
           (cell.pointLocation.latitude != 0.0f && cell.pointLocation.longitude != 0.0f)
           )
        {
            NSLog(@"cell.pointLocation.latitude = %f", cell.pointLocation.latitude);
            MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
            annotationPoint.coordinate = cell.pointLocation;
            annotationPoint.title = cell.titleLabel.text;
            [mapView addAnnotation:annotationPoint];
        }
    }
}

- (void) zoomMapToFitAnnotations
{
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in mapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        if (MKMapRectIsNull(zoomRect)) {
            zoomRect = pointRect;
        } else {
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
    }
    [mapView setVisibleMapRect:zoomRect animated:NO];
}

- (void) mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    [self displayMapViewAnnotationsForTableViewCells];
}
@end
