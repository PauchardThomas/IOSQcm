//
//  PrevisuQcmViewController.m
//  Qcm
//
//  Created by etudiant on 08/06/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "PrevisuQcmViewController.h"

@interface PrevisuQcmViewController ()

@end

@implementation PrevisuQcmViewController
@synthesize qcm,lbQcm,lbDuree;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    Qcm* q = (Qcm*) qcm;
    NSLog(@"%@",qcm.libelle);
    NSLog(@"%@",qcm.duration);
    lbQcm.text = qcm.libelle;
    
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString* date=[formatter stringFromDate:qcm.duration];
    lbDuree.text = date;
    
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
