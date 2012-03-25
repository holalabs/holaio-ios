//
//  ViewController.m
//  HolaIO
//
//  Created by Jorge Izquierdo on 3/18/12.
//  Copyright (c) 2012 JIzqApps. All rights reserved.
//

#import "ViewController.h"
#import "HolaIO.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize urlTf, selectorTf, outputTV;
- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)makeRequest:(id)sender{
    
    
    [self.urlTf resignFirstResponder];
    [self.selectorTf resignFirstResponder];
     HolaIO *hola = [HolaIO initializeWithAPIKey:@"yourapikey"];
    [hola sendRequestWithURL:self.urlTf.text cssSelector:self.selectorTf.text inner:YES completionBlock:^(NSDictionary *dataReturned) {
        
        NSString *data = [NSString stringWithFormat:@"%@", [dataReturned objectForKey:self.selectorTf.text]];
        [outputTV setText:data];
    }];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
