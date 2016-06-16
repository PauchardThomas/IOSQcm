//
//  AppDelegate.m
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "AppDelegate.h"
#import "Category.h"
#import "CategoryWSAdapter.h"
#import "CategorySqLiteAdapter.h"
#import "UserWSAdapter.h"
#import "UserSqLiteAdapter.h"
#import "QcmWSAdapter.h"
#import "QcmSqLiteAdapter.h"
#import "Question.h"
#import "Proposal.h"
#import "QuestionSqLiteAdapter.h"
#import "ProposalSqLiteAdapter.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    void (^callbackUser)(User*) = ^(User* user) {
        
        
        UserSqLiteAdapter* userAdapter = [UserSqLiteAdapter new ];
        
        //test if user already exist
        NSManagedObject* isUserExist = [userAdapter getByIdServer:user.id_server];
        
       // if(isUserExist.managedObjectContext == nil){
        //    User* usertest = (User*) isUserExist;
          //  NSLog(@"%@",usertest.username);
        //}else {
          //  NSLog(@"User existe déjà");
            NSManagedObjectID* idInserted = [userAdapter insert:user];
            NSLog(@"%@",idInserted);
            user.id = idInserted;
       // }
    };
    
    void (^callbackQcms)(NSMutableArray*) = ^(NSMutableArray* qcms) {
        
        if(qcms != nil){
            for (Qcm* qcm in qcms) {
                
                QcmSqLiteAdapter* adapter = [QcmSqLiteAdapter new];
               // CategorySqLiteAdapter* catadapter = [CategorySqLiteAdapter new ];
               // NSManagedObject* isQcmExist =[adapter getByIdServer:qcm];
                //if(isQcmExist.managedObjectContext == nil){
                    [adapter insert:qcm];
                //} else{
                //    [adapter update:isQcmExist withQcm:qcm];
               // }
            }
        }
    };
    
     void (^callbackQcm)(Qcm*) = ^(Qcm* qcm) {
         
         //Set id to Qcm
         QcmSqLiteAdapter *qcmSqlLiteAdapter = [QcmSqLiteAdapter new];
         qcm.id = [[qcmSqlLiteAdapter getByIdServer:qcm] objectID];
         
         for(Question* question in [qcm questions]) {
             
             QuestionSqLiteAdapter* questionSqlLiteAdapter = [QuestionSqLiteAdapter new ];
             question.qcm = qcm;
             question.id = [[questionSqlLiteAdapter insert:question] objectID];
             
             for(Proposal* proposal in question.proposals) {
                 proposal.question = question;
                 ProposalSqLiteAdapter* proposalSqlLiteAdapter = [ProposalSqLiteAdapter new ];
                 [proposalSqlLiteAdapter insert:proposal];
                 
             }
             
         }
     };

    
    void (^callback)(NSMutableArray*) = ^(NSMutableArray* categories) {
        
        if(categories != nil){
            for (EntityCategory* cat in categories) {
                
                CategorySqLiteAdapter* adapter = [CategorySqLiteAdapter new];
               // NSManagedObject* isCatExist =[adapter getByIdServer:cat];
               // if(isCatExist.managedObjectContext == nil){
                    [adapter insert:cat];
               // } else{
                //    [adapter update:isCatExist withCategory:cat];
                //}
            }
        }
    };
    
    
    CategoryWSAdapter* categoryWSAdatper = [CategoryWSAdapter new];
    [categoryWSAdatper getCategories:callback:5];
    
    UserWSAdapter* userdapater = [UserWSAdapter new ];
    [userdapater loginuser:callbackUser :@"admin" :@"admin"];
    
    QcmWSAdapter* qcmWSAdapter = [QcmWSAdapter new ];
    [qcmWSAdapter getQcms:callbackQcms :2];
    [qcmWSAdapter getQcm:callbackQcm :2];
    
   /* EntityCategory* cate = [EntityCategory new];
    cate.libelle = @"Ma 1ere cate";
    cate.id_server = 10;
    CategorySqLiteAdapter* adapter = [CategorySqLiteAdapter new];
    [adapter insert:cate];*/
    
    
 /*   WeatherWSAdapter* adapter = [WeatherWSAdapter new];
    [adapter getWheater:^(Weather * weather) {
        // on peut enregistre en bdd
        NSLog(weather.description);
    }];*/
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.iia.Qcm" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Qcm" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Qcm.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
