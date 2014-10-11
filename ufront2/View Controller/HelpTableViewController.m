//
//  HelpTableViewController.m
//  ufront2
//
//  Created by cyyun on 14-9-19.
//  Copyright (c) 2014年 cyyun. All rights reserved.
//

#import "HelpTableViewController.h"
#import "DetialedHelpViewController.h"
#import "Utils.h"

@interface HelpTableViewController ()

@property(nonatomic,copy) NSArray *helpArray;

@end

@implementation HelpTableViewController

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSArray*) helpArray
{
    if (_helpArray == nil) {
        _helpArray = [[NSArray alloc] init];
    }
    return _helpArray;
}

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
    
    [Utils setExtraTableCellLine:self.tableView];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"helpMe-QA" ofType:@"plist"];
    self.helpArray = [NSArray arrayWithContentsOfFile:path];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.helpArray.count == 0) {
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }else{
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return self.helpArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HelpCell"];
    
    // Configure the cell...
    
    cell.textLabel.text = [self.helpArray[indexPath.row] objectForKey:@"question"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"HelpDetail"]) {
        NSIndexPath * indexPath = [self.tableView indexPathForCell:sender];
        
        DetialedHelpViewController *detailedHtlpViewController = segue.destinationViewController;
        detailedHtlpViewController.question = [self.helpArray[indexPath.row] objectForKey:@"question"];
        detailedHtlpViewController.answer = [self.helpArray[indexPath.row] objectForKey:@"answer"];
    }
}


@end
