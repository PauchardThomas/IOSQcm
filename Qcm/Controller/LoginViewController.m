//
//  LoginViewController.m
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "LoginViewController.h"
#import "Weather.h"
#import "WeatherWSAdapter.h"
#import "CategoryViewController.h"
#import "UserSqLiteAdapter.h"
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
    
    void (^callback)(Weather*) = ^(Weather* weather) {
        idLabel.text = [NSString stringWithFormat:@"%d",weather.idServer];
        descriptionLabel.text = weather.description;
        mainLabel.text = weather.main;
    };
    
    
    WeatherWSAdapter* adapter = [WeatherWSAdapter new];
    [adapter getWheater:callback];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    usertosend = [User new];
    
    if([[segue identifier] isEqualToString:(@"FromLoginToCategories")]){
        
        void (^callbackUser)(User*) = ^(User* user) {
            
            
            UserSqLiteAdapter* userAdapter = [UserSqLiteAdapter new ];
            
            //test if user already exist
            NSManagedObject* isUserExist = [userAdapter getByIdServer:user];
            
            //if not exist : insert
            if(isUserExist.managedObjectContext == nil){
                
                
                NSManagedObjectID* idInserted = [userAdapter insert:user];
                NSLog(@"%@",idInserted);
                user.id = idInserted;
                
                usertosend.id = user.id;
                usertosend.username = user.username;
                usertosend.password = user.password;
                
            // User already exist
            } else {
                User* userExist = (User*) isUserExist;
                
                //usertosend.id = userExist.id;
                //usertosend.username = userExist.username;
                //usertosend.password = userExist.password;
            }
            
        };
        
        UserWSAdapter* userdapater = [UserWSAdapter new ];
        usertosend =[userdapater loginuser:callbackUser:loginLabel.text:PasswordLabel.text];
        

        
        CategoryViewController* cc = [segue destinationViewController];
        //cc.user = usertosend;
        
    }
}


@end
