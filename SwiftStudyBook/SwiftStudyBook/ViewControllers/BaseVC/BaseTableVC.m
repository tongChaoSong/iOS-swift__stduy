//
//  BaseTableVC.m
//  SwiftStudyBook
//
//  Created by Apple on 2020/8/19.
//  Copyright © 2020 tcs. All rights reserved.
//

#import "BaseTableVC.h"

@interface BaseTableVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * mainTable;
@end

@implementation BaseTableVC

-(void)setMainTitleArr:(NSArray *)mainTitleArr{
    _mainTitleArr = mainTitleArr;
    [self.mainTable reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self creatUI];
}
#pragma mark -- 懒加载
-(void)creatUI{
   
    [self.view addSubview:self.mainTable];
}
//
-(UITableView*)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, kApplicationStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kApplicationStatusBarHeight) style:UITableViewStyleGrouped];
        
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
//        _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTable.showsVerticalScrollIndicator = NO;
        _mainTable.showsHorizontalScrollIndicator = NO;
        _mainTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _mainTable.rowHeight = UITableViewAutomaticDimension;
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
        _mainTable.estimatedRowHeight = 0;
        _mainTable.estimatedSectionFooterHeight = 0;
        _mainTable.estimatedSectionHeaderHeight = 0;
        
        //        if ([_mainTable respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
        //            _mainTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        //        }
//        _mainTable.frame = CGRectMake(0, -(kApplicationStatusBarHeight-44), SCREEN_WIDTH, SCREEN_HEIGHT - 50 + (kApplicationStatusBarHeight-44));
#else
        self.automaticallyAdjustsScrollViewInsets = NO;
#endif
    }
    return _mainTable;
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mainTitleArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.mainTitleArr[indexPath.row];
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
