//
//  QcmTableViewController.m
//  Qcm
//
//  Created by etudiant on 08/06/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QcmTableViewController.h"
#import "PrevisuQcmViewController.h"
#import "QcmSqLiteAdapter.h"
#import "QuestionSqLiteAdapter.h"
#import "ProposalSqLiteAdapter.h"
@interface QcmTableViewController ()

@end

@implementation QcmTableViewController
@synthesize qcms,category,user;
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
    
    
    // Get all Qcms 
    QcmSqLiteAdapter* qcmSqLiteAdapter = [QcmSqLiteAdapter new];
    qcms =[qcmSqLiteAdapter getAll];
    for(Qcm* qcm in qcms) {
        NSLog(@"id server : %@",qcm.id_server);
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

    
    void (^callbackQcm)(Qcm*) = ^(Qcm* qcm) {
        
        //Set id to Qcm
        QcmSqLiteAdapter *qcmSqlLiteAdapter = [QcmSqLiteAdapter new];
        qcm.id = [[qcmSqlLiteAdapter getByIdServer:qcm] objectID];
        
        for(Question* question in [qcm questions]) {
            
            QuestionSqLiteAdapter* questionSqlLiteAdapter = [QuestionSqLiteAdapter new ];
            question.qcm = qcm;
            NSManagedObject* isQuestionExist =[questionSqlLiteAdapter getByIdServer:question];
            if(isQuestionExist == nil){
            question.id = [[questionSqlLiteAdapter insert:question] objectID];
            
                for(Proposal* proposal in question.proposals) {
                    proposal.question = question;
                    ProposalSqLiteAdapter* proposalSqlLiteAdapter = [ProposalSqLiteAdapter new ];
                    [proposalSqlLiteAdapter insert:proposal];
                
                }
            }
        }
    };
    

        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow]row];
        PrevisuQcmViewController* pq = [segue destinationViewController];
        
        Qcm* myqcm = [Qcm new];
        myqcm = [qcms objectAtIndex:selectedIndex];
        NSLog(@"myqcm id server : %@",myqcm.id_server);
        QcmWSAdapter* qcmWSAdapter = [QcmWSAdapter new ];
        [qcmWSAdapter getQcm:callbackQcm :myqcm.id_server ];
        pq.qcm = myqcm;
        pq.user = user;
        pq.category = self.category;
    
}


@end
