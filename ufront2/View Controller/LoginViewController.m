//
//  LoginViewController.m
//  ufront2
//
//  Created by cyyun on 14-9-19.
//  Copyright (c) 2014年 cyyun. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"
#import "Utils.h"
#import "MBProgressHUD.h"
@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) MBProgressHUD *HUD;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UILabel *seviceTelNumberLabel;

@end

@implementation LoginViewController

- (void)dealloc
{
    NSLog(@"LoginViewController is destroy!");
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
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loggIn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(telLabelEvent:)];
    _seviceTelNumberLabel.userInteractionEnabled = YES;
    [_seviceTelNumberLabel addGestureRecognizer:tapGestureTel];
    _userNameTextField.delegate = self;
    _userNameTextField.clearsOnBeginEditing = YES;
    _userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passWordTextField.delegate = self;
    _passWordTextField.clearsOnBeginEditing = YES;
    _passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    
    _userNameTextField.text = userName;
    _passWordTextField.text = password;
    
    //自动登录
    BOOL isAutoLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"autoLogin"];
    if (isAutoLogin) {
        [self doLoginAction:userName withPassWord:password];
    }
    
}

    //打服务电话
- (void)telLabelEvent:(UIGestureRecognizer *)gr {
    NSString *telPhoneStr = [NSString stringWithFormat:@"tel://%@",_seviceTelNumberLabel.text];
    NSURL *phoneURL = [NSURL URLWithString:telPhoneStr];
    
    UIWebView*callWebview =[[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    [self.view addSubview:callWebview];
}

//点击背景，从而关闭键盘
- (IBAction)closeKeyBoard:(id)sender {
    [_userNameTextField resignFirstResponder];
    [_passWordTextField resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)Login:(id)sender
{
    
    NSString *userName = _userNameTextField.text;
    NSString *userPwd = _passWordTextField.text;
    if ([Utils isBlankString:userName] || [Utils isBlankString:userPwd]) {
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.yOffset = -50;
        self.HUD.labelText = @"用户名或密码为空";
        [self.HUD hide:YES afterDelay:1.0];
        return;
    }
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.labelText = @"正在登录...";
    [self doLoginAction:userName withPassWord:userPwd];
    
}

-(void)doLoginAction:(NSString *)userName withPassWord:(NSString *)password
{
    NSString *md5Password = [Utils md5:password];
    
    NSString *loginUrl = [NSString stringWithFormat:@"%@/login.do?loginMobile=%@&password=%@",baseURLString,userName,md5Password];
    NSURL *url = [NSURL URLWithString:loginUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation* request,id responseObject){
        NSLog(@"JSON:%@",responseObject);
        
        int resultCode = [[responseObject objectForKey:@"resultCode"] intValue];
        
        if (resultCode == 0) {
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSString *sessionToken = [obj objectForKey:@"sessionToken"];
            [[NSUserDefaults standardUserDefaults]setObject:sessionToken forKey:@"sessionToken"];
            NSLog(@"sessionToken:%@",sessionToken);
            [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.HUD removeFromSuperview];
                [self doActionAfterLoginSuccess];
            }];
            
        }else {
            NSString *errorMessage = [responseObject objectForKey:@"errorMessage"];
            self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.labelText =errorMessage;
            self.HUD.yOffset = -50;
            self.HUD.removeFromSuperViewOnHide = YES;
            [self.HUD hide:YES afterDelay:1.0];
        }

    }failure:^(AFHTTPRequestOperation* request,NSError* error){
        NSLog(@"ERROR:%@",error);
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.labelText =@"服务器错误";
        self.HUD.yOffset = -50;
        self.HUD.removeFromSuperViewOnHide = YES;
        [self.HUD hide:YES afterDelay:1.0];
    }];
    [op start];

}


- (void)doActionAfterLoginSuccess
{
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loggedIn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    [self sendDeviceTokenToServer];
}

-(void)sendDeviceTokenToServer
{
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    NSLog(@"deviceToken:%@",deviceToken);
    if (deviceToken == nil || deviceToken.length<=0) {
        return;
    }
    NSString *sessionToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionToken"];
    NSString *updateDeviceTokenUrl = [NSString stringWithFormat:@"%@/updateDeviceToken.do?sessionToken=%@&type=%d&deviceToken=%@",baseURLString,sessionToken,0,deviceToken];
    NSURL *url = [NSURL URLWithString:updateDeviceTokenUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:nil failure:nil];
    [op start];
}

#pragma mark - textField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_userNameTextField isFirstResponder]) {
        [_passWordTextField becomeFirstResponder];
    }else{
        [self performSelector:@selector(Login:) withObject:self];
    }
    return YES;
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
