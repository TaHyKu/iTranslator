//
//  IATranslatorViewController.m
//  iTranslator
//
//  Created by TaHyKu on 06.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import "IATranslatorViewController.h"
#import "IATranslatorCellBuilder.h"
#import "IAServerManager+Translation.h"
#import "IAWord.h"

@interface IATranslatorViewController () <UITableViewDataSource, IATableViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, weak) IBOutlet UIButton *clearButton;
@property (nonatomic, weak) IBOutlet UILabel *noResultsLabel;
@property (nonatomic, strong)  UITableView *tableView;

@property (nonatomic, strong) IATranslatorCellBuilder *cellBuilder;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong) NSMutableIndexSet *insertedSections;
@property (nonatomic, strong) NSMutableIndexSet *deletedSections;

@property (nonatomic) BOOL isNoResults;

- (IBAction)clearAction:(id)sender;

@end

@implementation IATranslatorViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initialSetup];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


#pragma mark - Override
- (void)setIsNoResults:(BOOL)isNoResults {
    if (_isNoResults == isNoResults) { return; }
    
    self.tableView.hidden = isNoResults;
    self.noResultsLabel.hidden = !isNoResults;
    self.clearButton.hidden = isNoResults;
    _isNoResults = isNoResults;
}


#pragma mark - Setup
- (void)initialSetup {
    [self setupTableView];
    [self setupCellBuilders];
    [self setupFetchedResultsController];
    [self setupGestureRecognizers];
    [self setupReachabilityMonitor];
}

- (void)setupTableView {
    self.tableView = [IATableView tableViewWith:self delegate:self topOffset:64.0f];
    self.tableView.separatorColor = [UIColor lightBlue];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.allowsSelection = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView becomeFirstResponder];
    
    [self.view addSubview:self.tableView];
}

- (void)setupCellBuilders {
    self.cellBuilder = [[IATranslatorCellBuilder alloc] initWith:self.tableView];
}

- (void)setupFetchedResultsController {
    self.fetchedResultsController = [[IADataBaseManager shared] wordFetchedResultsControllerWith:self];
    self.isNoResults = (self.fetchedResultsController.fetchedObjects.count == 0);
}

- (void)setupGestureRecognizers {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(tapGesturerecognizerAction)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)setupReachabilityMonitor {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if ((status == AFNetworkReachabilityStatusUnknown) || (status == AFNetworkReachabilityStatusNotReachable)) { return; }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"translation == %@", [NSNull null]];
        NSArray *words = [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:predicate];
        for (IAWord *word in words) {
            [self translate:word];
        }
    }];
}


#pragma mark - Action
- (IBAction)clearAction:(id)sender {
    [self.tableView becomeFirstResponder];
    [[IAServerManager shared] cancelAllRequests];
    [[IADataBaseManager shared] deleteAllWords];
}

- (void)tapGesturerecognizerAction {
    [self.tableView becomeFirstResponder];
}

#pragma mark - Network
- (void)translate:(IAWord *)word {
    [[IAServerManager shared] translateWith:word.original success:^(NSDictionary *dictionary) {
        NSString *translation = ([dictionary[codeKey] integerValue] == 200) ? dictionary[textKey][0] : @"Error";
        [[IADataBaseManager shared] updateWord:word with:translation];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IAWord *word = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    return [self.cellBuilder cellWith:word for:indexPath];;
}


#pragma mark - IATableViewDelegate
- (void)doneButtonPressedWith:(NSString *)inputText {
    IAWord *word = [[IADataBaseManager shared] addWordWith:inputText translation:nil];
    [self translate:word];
}


#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
    
    self.insertedSections = [[NSMutableIndexSet alloc] init];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
    self.isNoResults = (self.fetchedResultsController.fetchedObjects.count == 0);
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:sectionIndex];
    
    switch(type) {
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.deletedSections addIndexes:indexSet];
            break;
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.insertedSections addIndexes:indexSet];
            break;
            
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch(type) {
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeMove:
            if(![indexPath isEqual:newIndexPath]) {
                [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            else if([self.insertedSections containsIndex:indexPath.section]) {
                [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView insertRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            else if([self.deletedSections containsIndex:indexPath.section]) {
                [self.tableView insertRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
            break;
            
        case NSFetchedResultsChangeUpdate:
            if(![self.deletedSections containsIndex:indexPath.section] && ![self.insertedSections containsIndex:indexPath.section]) {
                IAWord *word = [self.fetchedResultsController objectAtIndexPath:indexPath];
                [self.cellBuilder updateCellWith:word for:indexPath];
            }
            
            break;
    }
}

@end

