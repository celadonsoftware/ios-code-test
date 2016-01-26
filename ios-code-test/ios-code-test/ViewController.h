//
//  ViewController.h
//  ios-code-test
//
//  Created by Elliott Malone on 26/01/2016.
//  Copyright © 2016 Elliott Malone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

{
    NSMutableArray *fibonacciData;
}

@property (strong, nonatomic) IBOutlet UITableView *fibonacciTableView;

@end

