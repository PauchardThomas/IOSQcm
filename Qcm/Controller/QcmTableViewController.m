//
//  QcmTableViewController.m
//  Qcm
//
//  Created by etudiant on 08/06/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QcmTableViewController.h"
#import "PrevisuQcmViewController.h"
@interface QcmTableViewController ()

@end

@implementation QcmTableViewController
@synthesize qcms,category;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    void (^callbackQcm)(NSMutableArray*) = ^(NSMutableArray* qcms) {
        
        if(qcms != nil){
            for (Qcm* qcm in qcms) {
                
                QcmSqLiteAdapter* adapter = [QcmSqLiteAdapter new];
                NSManagedObject* isQcmExist =[adapter getByIdServer:qcm];
                if(isQcmExist.managedObjectContext == nil){
                    [adapter insert:qcm];
                } else{
                    [adapter update:isQcmExist withQcm:qcm];
                }
            }
        }
    };
    
    
    QcmWSAdapter* qcmWSAdatper = [QcmWSAdapter new];
    [qcmWSAdatper getQcms:callbackQcm:category.id_server];
    
    QcmSqLiteAdapter* qcmSqLiteAdapter = [QcmSqLiteAdapter new];
    qcms =[qcmSqLiteAdapter getAll];
    
    
    
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
    
    return [self.qcms count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QcmCell"];
    if (cell == nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QcmCell"];
    }
    Qcm *qcm = (self.qcms)[indexPath.row];
    cell.textLabel.text = qcm.libelle;
    
    return cell;
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

   // if([[segue identifier] isEqualToString:(@"FromQcmToQPrevisu")]){
        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow]row];
        PrevisuQcmViewController* pq = [segue destinationViewController];
        
        Qcm* myqcm = [Qcm new];
        myqcm = [qcms objectAtIndex:selectedIndex];
        pq.qcm = myqcm;
  //  }
}


@end
