//
//  QuestionViewController.h
//  Qcm
//
//  Created by etudiant on 18/06/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Qcm.h"
#import "QuestionSqLiteAdapter.h"
#import "ProposalSqLiteAdapter.h"
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

@end
