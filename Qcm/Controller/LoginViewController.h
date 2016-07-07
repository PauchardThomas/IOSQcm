//
//  LoginViewController.h
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "UserWSAdapter.h"
@interface LoginViewController : UIViewController
{
    // User
    User* user;
}
@property (weak, nonatomic) IBOutlet UITextField *loginLabel;

@property (weak, nonatomic) IBOutlet UITextField *PasswordLabel;

@property (weak, nonatomic) IBOutlet UIButton *connexionButton;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;


@end
