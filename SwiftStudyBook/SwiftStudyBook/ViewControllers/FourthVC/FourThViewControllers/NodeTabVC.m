//
//  NodeTabVC.m
//  SwiftStudyBook
//
//  Created by TCS on 2023/4/6.
//  Copyright © 2023 tcs. All rights reserved.
//

#import "NodeTabVC.h"
#import "PointListModel.h"

@interface NodeTabVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)UITableView * mainTable;
@property(nonatomic,assign)NSInteger rowCount;

@end

@implementation NodeTabVC
-(NSMutableArray*)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainTable];

    [self initData];
    

}
-(void)initData{


    for (int i = 0; i < 10; i++) {
        PointListModel * node = [[PointListModel alloc] init];
        node.array = [NSMutableArray new];
        node.parentID = @"";
        node.childrenID = @"";
        node.level = 0;
        node.name = [NSString stringWithFormat:@"第%d级结点",node.level];
//        node.leaf = (node.level < MaxLevel) ? NO : YES;
        node.root = NO;
        node.expand = NO;
        node.selected = NO;
        for (int j = 0; j < 5; j++) {
            PointListModel * node2 = [[PointListModel alloc] init];
            node2.parentID = @"";
            node2.childrenID = @"";
            node2.level = 1;
            node2.array = [NSMutableArray new];
            node2.name = [NSString stringWithFormat:@"第%d级结点",node2.level];
//            node2.leaf = (node2.level < MaxLevel) ? NO : YES;
            node2.root = NO;
            node2.expand = NO;
            node2.selected = NO;
            [node.array addObject:node2];
            for (int k = 0; k < 5; k++) {
                PointListModel * node3 = [[PointListModel alloc] init];
                node3.level = 2;
                node3.array = [NSMutableArray new];
                node3.name = [NSString stringWithFormat:@"第%d级结点",node3.level];
//                node3.leaf = (node3.level < MaxLevel) ? NO : YES;
                node3.root = NO;
                node3.expand = NO;
                node3.selected = NO;
                [node2.array addObject:node3];
                for (int p = 0; p < 5; p++) {
                    PointListModel * node4 = [[PointListModel alloc] init];
                    node4.level = 3;
                    node4.array = [NSMutableArray new];
                    node4.name = [NSString stringWithFormat:@"第%d级结点",node4.level];
//                    node4.leaf = (node4.level < MaxLevel) ? NO : YES;
                    node4.root = NO;
                    node4.expand = NO;
                    node4.selected = NO;
                    [node3.array addObject:node4];
                    
                }
            }
        }
        [self.dataArr addObject:node];
    }
    [self.mainTable reloadData];
   


}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * exHomeCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!exHomeCell) {
        exHomeCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    PointListModel * model = self.dataArr[indexPath.row];
    if (model.level == 1) {
        exHomeCell.backgroundColor = UIColor.redColor;
//            cell.textLabel.frame = CGRectMake(25, 14, 40, 25);
    }
    else if (model.level == 2){
        exHomeCell.backgroundColor = UIColor.brownColor;
//            cell.textLabel.frame = CGRectMake(35, 14, 40, 25);
    }
    else{
        exHomeCell.backgroundColor = UIColor.whiteColor;
//            cell.textLabel.frame = CGRectMake(10, 14, 40, 25);
    }
    exHomeCell.textLabel.text = model.name;
    return exHomeCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PointListModel * model = self.dataArr[indexPath.row];
    model.isOpen=!model.isOpen;
    self.rowCount = indexPath.row;
    if (model.isOpen) {
        [self insertDataArr:model.array];
//        [self expandChildrenNodesLevel:model.level atIndexPath:indexPath];

    }else{
        [self deleteRowWith:model.array deleteRow:indexPath.row];
//        [self hiddenChildrenNodesLevel:model.level atIndexPath:indexPath];

    }
}

////展开
//- (void)expandChildrenNodesLevel:(int)level atIndexPath:(NSIndexPath *)indexPath {
//    NSMutableArray * insertNodeRows = [NSMutableArray array];
//    int insertLocation = (int)indexPath.row + 1;
//    for (int i = 0; i < arc4random()%9; i++) {
//        PointListModel * node = [[PointListModel alloc] init];
//        node.parentID = @"";
//        node.childrenID = @"";
//        node.level = level + 1;
//        node.name = [NSString stringWithFormat:@"第%d级结点",node.level];
//        node.leaf = (node.level < MaxLevel) ? NO : YES;
//        node.root = NO;
//        node.expand = NO;
//        node.selected = NO;
//        [self.dataArr insertObject:node atIndex:insertLocation + i];
//        [insertNodeRows addObject:[NSIndexPath indexPathForRow:insertLocation + i inSection:indexPath.section]];
//    }
//
////    [self.mainTable reloadData];
//    //插入cell
//    [self.mainTable beginUpdates];
//    [self.mainTable insertRowsAtIndexPaths:[NSArray arrayWithArray:insertNodeRows] withRowAnimation:UITableViewRowAnimationNone];
//    [self.mainTable endUpdates];
//    [self.mainTable layoutIfNeeded];
//    //更新新插入的元素之后的所有cell的cellIndexPath
//    NSMutableArray * reloadRows = [NSMutableArray array];
//    int reloadLocation = insertLocation + (int)insertNodeRows.count;
//    for (int i = reloadLocation; i < self.dataArr.count; i++) {
//        [reloadRows addObject:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
//    }
//    [self.mainTable reloadRowsAtIndexPaths:reloadRows withRowAnimation:UITableViewRowAnimationNone];
//}
///**
//获取并隐藏父结点的子结点数组
//@param level 父结点的层级
//@param indexPath 父结点所在的位置
//*/
//- (void)hiddenChildrenNodesLevel:(int)level atIndexPath:(NSIndexPath *)indexPath {
//    NSMutableArray * deleteNodeRows = [NSMutableArray array];
//    int length = 0;
//    int deleteLocation = (int)indexPath.row + 1;
//    for (int i = deleteLocation; i < self.dataArr.count; i++) {
//        PointListModel * node = self.dataArr[i];
//        if (node.level > level) {
//            [deleteNodeRows addObject:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
//            length++;
//        }else{
//            break;
//        }
//    }
//
//
//    [self.dataArr removeObjectsInRange:NSMakeRange(deleteLocation, length)];
//    [self.mainTable beginUpdates];
//    [self.mainTable deleteRowsAtIndexPaths:deleteNodeRows withRowAnimation:UITableViewRowAnimationNone];
//    [self.mainTable endUpdates];
//    [self.mainTable layoutIfNeeded];
//    //更新删除的元素之后的所有cell的cellIndexPath
//    NSMutableArray * reloadRows = [NSMutableArray array];
//    int reloadLocation = deleteLocation;
//    for (int i = reloadLocation; i < self.dataArr.count; i++) {
//        [reloadRows addObject:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
//    }
//    [self.mainTable reloadRowsAtIndexPaths:reloadRows withRowAnimation:UITableViewRowAnimationNone];
//}
///**
// 更新当前结点下所有子节点的选中状态
// @param level 选中的结点层级
// @param selected 是否选中
// @param indexPath 选中的结点位置
// */
//- (void)selectedChildrenNodes:(int)level selected:(BOOL)selected atIndexPath:(NSIndexPath *)indexPath {
//    NSMutableArray * selectedNodeRows = [NSMutableArray array];
//    int deleteLocation = (int)indexPath.row + 1;
//    for (int i = deleteLocation; i < self.dataArr.count; i++) {
//        PointListModel * node = self.dataArr[i];
//        if (node.level > level) {
//            node.selected = selected;
//            [selectedNodeRows addObject:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
//        }else{
//            break;
//        }
//    }
//    [self.mainTable reloadRowsAtIndexPaths:selectedNodeRows withRowAnimation:UITableViewRowAnimationNone];
//}
//---------
///插入cell
-(void)insertDataArr:(NSMutableArray *)array{
    NSMutableArray *arr = [NSMutableArray array];
    [self insertModelArr:array resultArray:arr];
    
//    [self.mainTable reloadData];
    [self.mainTable beginUpdates];
    [self.mainTable insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.mainTable endUpdates];
    [self.mainTable layoutIfNeeded];
}

-(void)insertModelArr:(NSMutableArray *)array resultArray:(NSMutableArray *)resultArr{
    for (int i = 0; i < array.count; i++) {
        PointListModel *model = array[i];
        self.rowCount++;
        [self.dataArr insertObject:model atIndex:self.rowCount];
        NSIndexPath *index = [NSIndexPath indexPathForRow:self.rowCount inSection:0];
        [resultArr addObject:index];
        if (model.isOpen) {
            [self insertModelArr:model.array resultArray:resultArr];
        }
    }
}

///删除cell
-(void)deleteRowWith:(NSMutableArray *)array deleteRow:(NSInteger)row{
    NSMutableArray *arr = [NSMutableArray array];
    [self deleteRow:array deleteRow:row resultArray:arr];
//    [self.mainTable reloadData];
    [self.mainTable beginUpdates];
    [self.mainTable deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.mainTable endUpdates];
    [self.mainTable layoutIfNeeded];

}

-(void) deleteRow:(NSMutableArray *)array deleteRow:(NSInteger)row resultArray:(NSMutableArray *)resultArr{
    for (int i = 0; i < array.count; i++) {
        PointListModel *model = array[i];
        [self.dataArr removeObject:model];
        ++row;
        NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:0];
        [resultArr addObject:index];
        if (model.isOpen == YES) {
            [self deleteRow:model.array deleteRow:row resultArray:resultArr];
            NSIndexPath *index = resultArr.lastObject;
            row = index.row;
        }
    }
}
-(UITableView*)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50) style:UITableViewStyleGrouped];
//        _mainTable.backgroundColor = toolClassColor(@"#F6F6F6");
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        _mainTable.estimatedRowHeight = 0;
        _mainTable.estimatedSectionFooterHeight = 0;
        _mainTable.estimatedSectionHeaderHeight = 0;
        _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTable.showsVerticalScrollIndicator = NO;
        _mainTable.showsHorizontalScrollIndicator = NO;
        @WeakObj(self);
//        _mainTable.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
//            //上拉加载
//            [selfWeak moreData];
//        }];
//        _mainTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//            selfWeak.currenPage = 1;
//            [selfWeak initData];
//        }];
    }
    return _mainTable;
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
