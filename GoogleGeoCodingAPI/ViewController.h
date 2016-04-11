//
//  ViewController.h
//  GoogleGeoCodingAPI
//
//  Created by Tops on 12/18/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface ViewController : UIViewController<MKMapViewDelegate>
{
    MKAnnotationView * annotationView;
}
@property (weak, nonatomic) IBOutlet UITextField *txt_search;
- (IBAction)btn_action:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mp_vw;


@end

