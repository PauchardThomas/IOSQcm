//
//  PrevisuQcmViewController.h
//  Qcm
//
//  Created by etudiant on 08/06/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Qcm.h"
#import "User.h"
@interface PrevisuQcmViewController : UIViewController
@property(strong) Qcm* qcm;
@property(strong) User* user;
@property (weak, nonatomic) IBOutlet UILabel *lbQcm;
@property (weak, nonatomic) IBOutlet UILabel *lbDuree;

@end
