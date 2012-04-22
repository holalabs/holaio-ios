//
//  ViewController.h
//  HolaIO
//
//  Created by Jorge Izquierdo on 3/18/12.
//  Copyright (c) 2012 JIzqApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HolaIO.h"
@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    
    HolaIO *holaIO;
    NSArray *array;
}
@property (nonatomic, strong) IBOutlet UITextField *urlTf, *selectorTf;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
-(IBAction)cached:(id)sender;
-(IBAction)nocached:(id)sender;
@end
