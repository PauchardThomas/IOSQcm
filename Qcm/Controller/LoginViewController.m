//
//  LoginViewController.m
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "LoginViewController.h"
#import "CategoryViewController.h"
#import "UserSqLiteAdapter.h"
#import "UIView+Toast.h"
#import "Hash.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize idLabel,descriptionLabel,mainLabel,connexionButton,loginLabel,PasswordLabel;
User* usertosend;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // changer le libelle suivant la langue
    [self.connexionButton setTitle:NSLocalizedString(@"Connexion", nil) forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

-(BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    usertosend = [User new];
    void (^callbackUser)(User*) = ^(User* user) {
        
        
        UserSqLiteAdapter* userAdapter = [UserSqLiteAdapter new ];
        
        //test if user already exist
        NSManagedObject* isUserExist = [userAdapter getByIdServer:user];
        
        //if not exist : insert
        if(isUserExist == nil){
            
            
            NSManagedObjectID* idInserted = [userAdapter insert:user];
            NSLog(@"%@",idInserted);
            user.id = idInserted;
            
            usertosend.id = user.id;
            usertosend.username = user.username;
            usertosend.password = user.password;
            
            // User already exist
        } else {
            User* userExist = (User*) isUserExist;
            
        }
        
    };
    
    // Hash password
    Hash* hash = [Hash new];
    NSString* passwordHashed =[hash hash:PasswordLabel.text];
    UserWSAdapter* userdapater = [UserWSAdapter new ];
    usertosend =[userdapater loginuser:callbackUser:loginLabel.text:passwordHashed];
    
    //DEBUG DB path
    /*NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString* documentDirectory = [paths objectAtIndex:0];
    NSLog(@"path is %@",documentDirectory);*/
    
    
    // Test if ids are corrects
    UserSqLiteAdapter* usersqlAdapter = [UserSqLiteAdapter new];
    Hash* h = [Hash new];
    NSString* ph =[h hash:PasswordLabel.text];
    usertosend =(User*) [usersqlAdapter getBy:loginLabel.text :ph];
    if(usertosend == nil) {
        [self.view makeToast:@"Identifiants incorrects"];
        return NO;
    }else {
        return YES;
    }
    return NO;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:(@"FromLoginToCategories")]){

        // Send user to categories page
        
        usertosend = [User new];
        UserSqLiteAdapter* usersqlAdapter = [UserSqLiteAdapter new];
        Hash* hash = [Hash new];
        NSString* passwordHashed =[hash hash:PasswordLabel.text];
        usertosend =(User*) [usersqlAdapter getBy:loginLabel.text :passwordHashed];
        CategoryViewController* cc = [segue destinationViewController];
        cc.user = usertosend;
        
    }
}


@end
