//
//  DetialedHelpViewController.m
//  ufront2
//
//  Created by cyyun on 14-9-19.
//  Copyright (c) 2014年 cyyun. All rights reserved.
//

#import "DetialedHelpViewController.h"
#import "Utils.h"

@interface DetialedHelpViewController ()

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextView *answerTextView;

@end

@implementation DetialedHelpViewController

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    
    _questionLabel.text = [NSString stringWithFormat:@"   %@",_question];
    if([Utils getSystemVersion] >= 6.0){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = 5.0f;
        paragraphStyle.firstLineHeadIndent = 20.f;
        paragraphStyle.alignment = NSTextAlignmentJustified;
        
        NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:17], NSParagraphStyleAttributeName:paragraphStyle
                                      };
        _answerTextView.attributedText = [[NSAttributedString alloc]initWithString:_answer attributes:attributes];
    }else{
        _answerTextView.text = _answer;
    }
    _answerTextView.editable = NO;

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
