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
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIImageView+AFNetworking.h"
#import "UIActionSheet+UFBlock.h"

@interface SettingTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImageView;
@property (nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, strong) UIImage *pickerImage;

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
    _userPhotoImageView.layer.cornerRadius = 5.0f;
    _userPhotoImageView.layer.masksToBounds = YES;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *sessionToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"sessionToken"];
    NSString *updateUserPhotoUrl = [NSString stringWithFormat:@"%@/updateUserPhoto.do?sessionToken=%@",baseURLString,sessionToken];
    NSURL *URL = [NSURL URLWithString:updateUserPhotoUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    __weak typeof(self) weakSelf = self;
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation* request,id responseObject){
        NSLog(@"JSON:%@",responseObject);
        
        int resultCode = [[responseObject objectForKey:@"resultCode"] intValue];
        
        if (resultCode == 0) {
            NSString *thumbnailUrl = [NSString stringWithFormat:@"%@%@",commonURL,[responseObject objectForKey:@"photoPath"]];
            [weakSelf.userPhotoImageView setImageWithURL:[NSURL URLWithString:thumbnailUrl] placeholderImage:[UIImage imageNamed:@"icon_photo"]];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        }else if(resultCode == -2)
        {
//            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你的账号在其他地方登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重新登录", nil];
//            [alertView show];
//            alertView.block = ^(NSInteger buttonIndex){
//                if (buttonIndex == 0) {
//                }else{
//                    [UFUtility exitToLogin];
//                }
//            };
            
        }else {
            
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView dataSource

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20.0f;
    }else{
        return 10.0f;
    }
}


#pragma mark - UITableView delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSLog(@"选择图片");
        [self takeUserPhotoAction];
    }
}



//选取头像
- (void)takeUserPhotoAction
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil
                                                    cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择",nil
                                  
                                  ];
    
    actionSheet.completionBlock = ^(UIActionSheet *actionSheet, NSUInteger buttonIndex){
        if (buttonIndex == 0) {
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.allowsEditing = YES;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
            
        }else if(buttonIndex == 1){
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            imagePicker.allowsEditing = YES;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
    };
    
    [actionSheet showFromTabBar:self.navigationController.tabBarController.tabBar];
}


#pragma mark - UIImagePicker Delegate

//把头像上传至服务器
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    NSLog(@"%@", info);
//    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//    [self getSizableImage:image andSize:CGSizeMake(200.0f, 200.0f)];
//    
//    NSString *sessionToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionToken"];
//    NSString *uploadPhotoUrl = [NSString stringWithFormat:@"%@/uploadHeadPhoto.do?sessionToken=%@",commonUrl,sessionToken];
//    UFHttpRequest *httpRequest = [[UFHttpRequest alloc] init];
//    httpRequest.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    httpRequest.HUD.labelText = @"正在上传中...";
//    __weak typeof(self) weakSelf = self;
//    [httpRequest startAsynUploadWithURL:[NSURL URLWithString:uploadPhotoUrl] image:_pickerImage completionHandler:^(NSData *responseData) {
//        if (responseData)
//        {
//            
//            JSONDecoder *decoder = [[JSONDecoder alloc] init];
//            NSDictionary *ret = [decoder objectWithData:responseData];
//            if (ret == nil) {
//                weakSelf.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                weakSelf.HUD.mode = MBProgressHUDModeText;
//                weakSelf.HUD.labelText =@"服务器错误";
//                weakSelf.HUD.yOffset = -50;
//                weakSelf.HUD.removeFromSuperViewOnHide = YES;
//                [weakSelf.HUD hide:YES afterDelay:1.0];
//            }else {
//                int resultCode = [[ret objectForKey:@"resultCode"] intValue];
//                
//                if (resultCode == 0) {
//                    
//                    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                    self.HUD.mode = MBProgressHUDModeCustomView;
//                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
//                    self.HUD.customView = imageView;
//                    self.HUD.labelText = @"上传成功";
//                    self.HUD.yOffset = -50;
//                    [self.HUD hide:YES afterDelay:1.0];
//                    
//                    NSString *photoPath = [ret objectForKey:@"photoPath"];
//                    weakSelf.imagePath = [NSString stringWithFormat:@"%@%@&type=0",picCommonUrl,photoPath];
//                    [[SDImageCache sharedImageCache] storeImage:_pickerImage forKey:weakSelf.imagePath];
//                    
//                    
//                }else {
//                    
//                    NSString *alertErrorMessage = [ret objectForKey:@"errorMessage"];
//                    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                    self.HUD.mode = MBProgressHUDModeText;
//                    self.HUD.labelText =alertErrorMessage;
//                    self.HUD.yOffset = -50;
//                    self.HUD.removeFromSuperViewOnHide = YES;
//                    [self.HUD hide:YES afterDelay:1.0];
//                }
//            }
//        }else{
//            self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            self.HUD.mode = MBProgressHUDModeText;
//            self.HUD.labelText =@"网络连接异常";
//            self.HUD.yOffset = -50;
//            self.HUD.removeFromSuperViewOnHide = YES;
//            [self.HUD hide:YES afterDelay:1.0];
//        }
//        
//    }];
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
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


#pragma mark - mymethod

- (void)getSizableImage:(UIImage *)image andSize:(CGSize)size
{
    CGSize origImageSize = image.size;
    
    
    CGRect newRect = CGRectMake(0, 0, size.width, size.height);
    
    float ratio = MAX(size.width/origImageSize.width, size.height/origImageSize.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:0.0f];
    [path addClip];
    
    CGRect projectRect;
    projectRect.size.width = ratio * origImageSize.width;
    projectRect.size.height = ratio * origImageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;
    
    [image drawInRect:projectRect];
    
    _pickerImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
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
