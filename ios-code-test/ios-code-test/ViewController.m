//
//  ViewController.m
//  ios-code-test
//
//  Created by Elliott Malone on 26/01/2016.
//  Copyright © 2016 Elliott Malone. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initialize array for results data.
    fibonacciData = [NSMutableArray new];
    
    [self calculateSequence];
}

-(void)calculateSequence{
    
    // updated to use NSDecimalNumber instead of unsigned integers.
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        
        // manually set the first two fibonacci numbers (1,1).
        NSDecimalNumber *firstNumber = [NSDecimalNumber decimalNumberWithString:@"1"];
        NSDecimalNumber *secondNumber = [NSDecimalNumber decimalNumberWithString:@"1"];
        [fibonacciData addObject:[NSString stringWithFormat: @"%@", firstNumber]];
        [fibonacciData addObject:[NSString stringWithFormat: @"%@", secondNumber]];
        
        NSDecimalNumber *nextNumber = 0;
        
        // use while with always TRUE because we don't know how many loops are needed.
        BOOL flag = TRUE;
        while(flag){
            
            // check nextNumber will be no larger than max NSDecimalNumber.
            NSDecimalNumber *decMAX = [NSDecimalNumber maximumDecimalNumber];
            
            if([secondNumber compare:[decMAX decimalNumberBySubtracting:firstNumber]] == NSOrderedSame || [secondNumber compare:[decMAX decimalNumberBySubtracting:firstNumber]] == NSOrderedAscending){
                nextNumber = [firstNumber decimalNumberByAdding:secondNumber];
            } else {
                break;
            }
            
            // add nextNumber as string to resuls data
            [fibonacciData addObject:[NSString stringWithFormat: @"%@", nextNumber]];
            firstNumber = secondNumber;
            secondNumber = nextNumber;
            
            
        }
        // reload Table View on main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.fibonacciTableView reloadData];
        });
    });
}

// TableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [fibonacciData count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = @"fibonacci";
    UITableViewCell *cell = [self.fibonacciTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    } 
    
    // display result for row
    cell.textLabel.text = fibonacciData[indexPath.row]; 
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
