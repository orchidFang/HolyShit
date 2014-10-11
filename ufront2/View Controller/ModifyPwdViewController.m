//
//  ModifyPwdViewController.m
//  ufront2
//
//  Created by cyyun on 14-9-19.
//  Copyright (c) 2014年 cyyun. All rights reserved.
//

#import "ModifyPwdViewController.h"
#import "Utils.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

@interface ModifyPwdViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *latestPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation ModifyPwdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.oldPasswordTextField.delegate = self;
    self.oldPasswordTextField.clearsOnBeginEditing = YES;
    self.oldPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.latestPasswordTextField.delegate = self;
    self.latestPasswordTextField.clearsOnBeginEditing = YES;
    self.latestPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.confirmPasswordTextField.delegate = self;
    self.confirmPasswordTextField.clearsOnBeginEditing = YES;
    self.confirmPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)validatePassword
{
    if ([Utils isBlankString:_oldPasswordTextField.text] || [Utils isBlankString:_latestPasswordTextField.text] || [Utils isBlankString:_confirmPasswordTextField.text]) {
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.labelText =@"密码不能为空";
        self.HUD.yOffset = -50;
        self.HUD.removeFromSuperViewOnHide = YES;
        [self.HUD hide:YES afterDelay:1.0];
        
        return NO;
    }
    if (![_latestPasswordTextField.text isEqualToString:_confirmPasswordTextField.text]) {
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.labelText =@"新密码和确认密码不一致！";
        self.HUD.yOffset = -50;
        self.HUD.removeFromSuperViewOnHide = YES;
        [self.HUD hide:YES afterDelay:1.0];
        return NO;
    }
    
    if (_latestPasswordTextField.text.length <6 || _confirmPasswordTextField.text.length <6) {
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.labelText =@"新密码不能少于6位";
        self.HUD.yOffset = -50;
        self.HUD.removeFromSuperViewOnHide = YES;
        [self.HUD hide:YES afterDelay:1.0];
        return NO;
    }
    return YES;
}

-(IBAction)modifyPasswordAction:(id)sender
{
    BOOL isCorrectPassword = [self validatePassword];
    if (!isCorrectPassword) return;
    NSString *md5OldPassword = [Utils md5:_oldPasswordTextField.text];
    NSString *md5ConfirmPassword = [Utils md5:_confirmPasswordTextField.text];
    NSString* sessionToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"sessionToken"];
    NSLog(@"oldPasswordmd5:%@,newpasswordmd5:%@",md5OldPassword,md5ConfirmPassword);
    
    
    NSString *modifyUrl = [NSString stringWithFormat:@"%@/modifypassword.do?sessionToken=%@&oldPasswordmd5:%@,newpasswordmd5:%@",baseURLString,sessionToken,md5OldPassword,md5ConfirmPassword];
    NSURL *url = [NSURL URLWithString:modifyUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation* request,id responseObject){
        NSLog(@"JSON:%@",responseObject);
        
        int resultCode = [[responseObject objectForKey:@"resultCode"] intValue];
        
        if (resultCode == 0) {
            NSLog(@"修改成功");
            self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.labelText =@"成功修改密码";
            self.HUD.yOffset = -50;
            self.HUD.removeFromSuperViewOnHide = YES;
            [self.HUD hide:YES afterDelay:1.0];
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull*NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }
        else
        {
            NSString *alertErrorMessage = [responseObject objectForKey:@"errorMessage"];
            self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.labelText =alertErrorMessage;
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

#pragma mark textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.oldPasswordTextField isFirstResponder]) {
        [self.latestPasswordTextField becomeFirstResponder];
    }else if([self.latestPasswordTextField isFirstResponder]) {
        [self.confirmPasswordTextField becomeFirstResponder];
    }else{
        [self performSelector:@selector(modifyPasswordAction:) withObject:self];
    }
    return  YES;
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
