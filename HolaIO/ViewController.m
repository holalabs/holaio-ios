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
@synthesize urlTf, selectorTf, tableView;

- (void)viewDidLoad
{
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    holaIO = [HolaIO initializeWithAPIKey:@"4f6f4203fbece1b563000041"];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)cached:(id)sender{
    
    array = nil;
    [self.tableView reloadData];
    [self.urlTf resignFirstResponder];
    [self.selectorTf resignFirstResponder];
    [holaIO sendRequestWithURL:self.urlTf.text cssSelector:self.selectorTf.text inner:YES cache:YES completionBlock:^(NSDictionary *dataReturned, NSError *error) {
        
        array = [dataReturned objectForKey:self.selectorTf.text];
        [self.tableView reloadData];
        
    }];
}
-(IBAction)nocached:(id)sender{
    
    array = nil;
    [self.tableView reloadData];
    [self.urlTf resignFirstResponder];
    [self.selectorTf resignFirstResponder];
    [holaIO sendRequestWithURL:self.urlTf.text cssSelector:self.selectorTf.text inner:YES cache:NO completionBlock:^(NSDictionary *dataReturned,NSError *error) {
        
        array = [dataReturned objectForKey:self.selectorTf.text];
        [self.tableView reloadData];
    }];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [array count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    return cell;
}
@end
