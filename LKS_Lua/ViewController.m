//
//  ViewController.m
//  LKS_Lua
//
//  Created by Sơn Lê Khắc on 4/6/14.
//  Copyright (c) 2014 Sơn Lê Khắc. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "AppTest.h"
@interface ViewController ()

@end

@implementation ViewController

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
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionCallLuaFN:(id)sender {
    AppTest *aap=[AppTest ShareInstall];
    [aap CallLuaFN:@"KhoiTaoAlertview"];
}















@end




















