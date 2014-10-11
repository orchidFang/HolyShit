//
//  SettingTableViewController.m
//  ufront2
//
//  Created by cyyun on 14-9-19.
//  Copyright (c) 2014年 cyyun. All rights reserved.
//

#import "SettingTableViewController.h"
#import "Utils.h"
#import "UIAlertView+UFBlock.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface SettingTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation SettingTableViewController

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
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    _userNameLabel.text = userName;
    
    _versionLabel.text = [NSString stringWithFormat:@"V %@",[Utils curAppVersion]];
    
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
    return 3;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        default:
            return 0;
            break;
    }
}


-(IBAction)exitLogin:(id)sender
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"确定是否退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
     __weak typeof(self) weakSelf = self;
    alertView.completionBlock = ^(UIAlertView *alertView, NSUInteger buttonIndex){
        if (buttonIndex == 0) {
        }else{
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setBool:NO forKey:@"autoLogin"];
            [userDefaults synchronize];
            
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            UITabBarController *tabBarController = (UITabBarController *)appDelegate.window.rootViewController;
            [tabBarController setSelectedIndex:0];
            
            //出现登录界面
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            LoginViewController *loginViewController = [storyBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            
            [weakSelf presentViewController:loginViewController animated:NO completion:nil];

            
        }
    };
    
    [alertView show];

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
