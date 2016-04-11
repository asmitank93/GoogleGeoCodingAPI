//
//  ViewController.m
//  GoogleGeoCodingAPI
//
//  Created by Tops on 12/18/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize txt_search,mp_vw;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    mp_vw.delegate=self;
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    /*
    if([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    */
    static NSString *identifier = @"myAnnotation";
    
    annotationView = (MKAnnotationView *)[self.mp_vw dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!annotationView)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        
        annotationView.image = [UIImage imageNamed:@"MapMarker_Flag3_Left_Chartreuse.png"];
        

        //annotationView.calloutOffset = CGPointMake(-5, 5);
        
    }
    else
    {
        annotationView.annotation = annotation;
    }
    //annotationView.tag = annotationTag;
    
    return annotationView;
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
    
    /*
    UIImageView *vw=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,50,50)];
    vw.image=[UIImage imageNamed:@"callout-letf-md.png"];
    
    //annotationView2.tag = selectedAnnotation;
    
    //UILabel *nameLbl = (UILabel *)[annotationView viewWithTag:[here give ur tag which u set in custom view]];
    [view addSubview:vw];
    */
    
    UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [infoButton setTitle:@"sssssss" forState:UIControlStateNormal];
    [infoButton setFrame:CGRectMake(0, 0, CGRectGetWidth(infoButton.frame)+10, CGRectGetHeight(infoButton.frame))];
    [infoButton setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin];
    [infoButton addTarget:self action:@selector(btn_click:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:infoButton];
}

-(void)btn_click:(id)sender
{
    UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"Clicked" message:@"map" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [alrt show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_action:(id)sender
{
    [self.view endEditing:YES];
    NSString *st_format=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@",[txt_search.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:st_format]];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    if (dict.allKeys.count>0)
    {
        float lat=[[[[[[dict objectForKey:@"results"]objectAtIndex:0]objectForKey:@"geometry"]objectForKey:@"location"]objectForKey:@"lat"]floatValue];
        float lng=[[[[[[dict objectForKey:@"results"]objectAtIndex:0]objectForKey:@"geometry"]objectForKey:@"location"]objectForKey:@"lng"]floatValue];
        
        CLLocationCoordinate2D loc;
        loc.latitude=lat;
        loc.longitude=lng;
        
        MKCoordinateRegion regin;
        regin.center=loc;
        regin.span.latitudeDelta=0.01;
        regin.span.longitudeDelta=0.01;
        
        MKPointAnnotation *point=[[MKPointAnnotation alloc]init];
        [point setCoordinate:loc];
        
        [mp_vw addAnnotation:point];
        [mp_vw setRegion:regin animated:YES];
        [mp_vw regionThatFits:regin];
    }
    
}
@end
