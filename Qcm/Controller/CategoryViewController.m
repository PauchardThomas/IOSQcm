//
//  CategoryViewController.m
//  Qcm
//
//  Created by etudiant on 31/05/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Username : %@",_user.username);
    NSLog(@"Username : %@",_user.password);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
