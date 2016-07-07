//
//  CategoryViewController.m
//  Qcm
//
//  Created by etudiant on 31/05/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryWSAdapter.h"
#import "CategorySqLiteAdapter.h"
#import "Category.h"
#import "UIView+Toast.h"
#import "QcmTableViewController.h"
@interface CategoryViewController ()
{
    EntityCategory* categoryClicked;
}
@end

@implementation CategoryViewController
@synthesize category,categories,user,fromQuestions;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setHidesBackButton:YES];
    

    NSLog(@"Username : %@",user.username);
    NSLog(@"Username : %@",user.password);
    
    User* u = user;
    NSLog(@"login : %@",u.username);
    
    void (^callback)(NSMutableArray*) = ^(NSMutableArray* categories) {
        //
        if(categories != nil){
            for (EntityCategory* cat in categories) {
                
                CategorySqLiteAdapter* adapter = [CategorySqLiteAdapter new];
                NSManagedObject* isCatExist =[adapter getByIdServer:cat];
                if(isCatExist.managedObjectContext == nil){
                    [adapter insert:cat];
                } else{
                    [adapter update:isCatExist withCategory:cat];
                }
            }
        }
    };

    
    // Get categories from user
    CategoryWSAdapter* categoryWSAdatper = [CategoryWSAdapter new];
    [categoryWSAdatper getCategories:callback:[user.id_server intValue]];
    
    // Get all categories from db
    CategorySqLiteAdapter* categorySqLiteAdapter = [CategorySqLiteAdapter new];
    categories =[categorySqLiteAdapter getAll];
    
    if(fromQuestions == 1) {
       // [self.view makeToast:@"Réponses envoyées"];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Réponses envoyées" message:@""preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionBack = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:actionBack];
        [self presentViewController:alertController animated:YES completion:nil];
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.categories count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    if (cell == nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CategoryCell"];
    }
    EntityCategory *category = (self.categories)[indexPath.row];
    cell.textLabel.text = category.libelle;
    //cell.detailTextLabel.text = ville.Cp;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // inutile ici déja fais dans le segue villeClick = [self.villes objectAtIndex:indexPath.row];
    
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    if([[segue identifier] isEqualToString:(@"FromCategoryToQcm")]){
        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow]row];
        QcmTableViewController* tv = [segue destinationViewController];
        
        EntityCategory* mycat = [EntityCategory new];
        mycat = [categories objectAtIndex:selectedIndex];
        NSLog(@"id server : %@",mycat.id_server);
        tv.category = mycat;
        tv.user = user;
    }
}


@end
