//
//  CategoryViewController.h
//  Qcm
//
//  Created by etudiant on 31/05/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Category.h"
@interface CategoryViewController : UITableViewController

@property(strong) User* user;
@property(strong) EntityCategory* category;
@property (strong) NSArray* categories;
@end
