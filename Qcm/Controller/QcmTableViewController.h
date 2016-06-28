//
//  QcmTableViewController.h
//  Qcm
//
//  Created by etudiant on 08/06/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"
#import "Qcm.h"
#import "User.h"
#import "QcmWSAdapter.h"
#import "QcmSqLiteAdapter.h"
@interface QcmTableViewController : UITableViewController
@property(strong) EntityCategory* category;
@property(strong) Qcm* qcm;
@property(strong)User* user;
@property (strong) NSArray* qcms;
@end
