//
//  ViewController.h
//  HolaIO
//
//  Created by Jorge Izquierdo on 3/18/12.
//  Copyright (c) 2012 JIzqApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HolaIO.h"
@interface ViewController : UIViewController
{
    
    HolaIO *holaIO;
}
@property (nonatomic, strong) IBOutlet UITextField *urlTf, *selectorTf;
@property (nonatomic, strong) IBOutlet UITextView *outputTV;
-(IBAction)cached:(id)sender;
-(IBAction)nocached:(id)sender;
@end
