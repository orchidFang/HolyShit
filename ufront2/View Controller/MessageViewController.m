//
//  MessageViewController.m
//  ufront2
//
//  Created by cyyun on 14-9-22.
//  Copyright (c) 2014年 cyyun. All rights reserved.
//

#import "MessageViewController.h"
#import "LoginViewController.h"
#import "VersionManager.h"
#import "Utils.h"
#import "UIAlertView+UFBlock.h"
#import "MBProgressHUD.h"

@interface MessageViewController ()<UISearchBarDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UISearchBar *messageSearchBar;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *messageTableView;
@property (nonatomic,copy) NSMutableArray *messageInfoArray;
@property (nonatomic, strong)MBProgressHUD *HUD;
@end

@implementation MessageViewController

-(NSMutableArray *)messageInfoArray
{
    if (_messageInfoArray == nil) {
        _messageInfoArray = [[NSMutableArray alloc] init];
    }
    
    return _messageInfoArray;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //已经登录了
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loggedIn"]) {
    
        //隐藏多余的分割线
        [Utils setExtraTableCellLine:self.messageTableView];
        
        VersionManager *versionManager = [[VersionManager alloc] init];
        __weak typeof (self) weakSelf = self;
        [versionManager setCompletionBlock:^(int hasNewVersion){
            if (hasNewVersion == 1) {
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"更新提示" message:@"有新版本，请点击下载更新" delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"更新", nil];
                [alertView show];
                alertView.completionBlock = ^(UIAlertView *alertView,NSUInteger buttonIndex){
                    if (buttonIndex == 0) {
                    }else{
                        NSLog(@"下载");
                        NSString *downloadurl = [NSString stringWithFormat:@"%@/uf/ios",commonURL];
                        NSURL *updateURL = [NSURL URLWithString:downloadurl];
                        if ([[UIApplication sharedApplication] canOpenURL:updateURL]) {
                            [[UIApplication sharedApplication] openURL:updateURL];
                        }else{
                            weakSelf.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            weakSelf.HUD.mode = MBProgressHUDModeText;
                            weakSelf.HUD.labelText =@"您的设备不支持打开更新链接!";
                            weakSelf.HUD.yOffset = -50;
                            weakSelf.HUD.removeFromSuperViewOnHide = YES;
                            [weakSelf.HUD hide:YES afterDelay:1.0];
                        }
                        
                    }
                };
                
            }
        }];
        
        [versionManager checkNewVersion];
    }else{
        //出现登录界面
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        LoginViewController *loginViewController = [storyBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self presentViewController:loginViewController animated:NO completion:nil];
    }
    
    self.messageSearchBar.delegate = self;
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
