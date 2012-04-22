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
    holaIO = [HolaIO initializeWithAPIKey:@"4f6f4203fbece1b563000041"];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)cached:(id)sender{
    
    [outputTV setText:nil];
    [self.urlTf resignFirstResponder];
    [self.selectorTf resignFirstResponder];
    [holaIO sendRequestWithURL:self.urlTf.text cssSelector:self.selectorTf.text inner:YES cache:YES completionBlock:^(NSDictionary *dataReturned, NSError *error) {
        
        NSString *data = [NSString stringWithFormat:@"%@", [dataReturned objectForKey:self.selectorTf.text]];
        [outputTV setText:data];
    }];
}
-(IBAction)nocached:(id)sender{
    
    [outputTV setText:nil];
    [self.urlTf resignFirstResponder];
    [self.selectorTf resignFirstResponder];
    [holaIO sendRequestWithURL:self.urlTf.text cssSelector:self.selectorTf.text inner:YES cache:NO completionBlock:^(NSDictionary *dataReturned,NSError *error) {
        
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
