//
//  QuestionViewController.h
//  Qcm
//
//  Created by etudiant on 18/06/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Qcm.h"
#import "User.h"
#import "QuestionSqLiteAdapter.h"
#import "ProposalSqLiteAdapter.h"
#import "Category.h"
@interface QuestionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbQuestion;
@property (weak, nonatomic) IBOutlet UILabel *lbR1;
@property (weak, nonatomic) IBOutlet UILabel *lbR2;
@property (weak, nonatomic) IBOutlet UILabel *lbR3;
@property (weak, nonatomic) IBOutlet UILabel *lbR4;
@property (weak, nonatomic) IBOutlet UISwitch *swR1;
@property (weak, nonatomic) IBOutlet UISwitch *swR2;
@property (weak, nonatomic) IBOutlet UISwitch *swR3;
@property (weak, nonatomic) IBOutlet UISwitch *swR4;
@property (strong) Qcm* qcm;
@property (strong) User* user;
@property (strong) EntityCategory* category;
- (IBAction)sw1:(id)sender;
- (IBAction)sw2:(id)sender;
- (IBAction)sw3:(id)sender;
- (IBAction)sw4:(id)sender;
- (IBAction)previous:(id)sender;
- (IBAction)next:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbUser;
@property (weak, nonatomic) IBOutlet UILabel *lbCategory;
@property (weak, nonatomic) IBOutlet UILabel *lbQcm;


@end
